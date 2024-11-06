import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ["video", "canvas"]

  connect() {
    this.startWebcam()
    this.createSubscription()

  }

  startWebcam() {
    navigator.mediaDevices.getUserMedia({ video: true })
      .then(stream => {
        this.videoTarget.srcObject = stream
        this.videoTarget.play()
      })
      .catch(err => {
        console.error("Error accessing webcam: ", err)
      })
  }

  createSubscription() {
    this.channel = createConsumer().subscriptions.create("ChatChannel", {
      received: (data) => {
        console.log("received data from backend", data)
      }
    })
  }

  capture() {
    const canvas = this.canvasTarget
    const context = canvas.getContext("2d")
    canvas.width = this.videoTarget.videoWidth
    canvas.height = this.videoTarget.videoHeight
    context.drawImage(this.videoTarget, 0, 0, canvas.width, canvas.height)

    const imageData = canvas.toDataURL("image/png")
    this.channel.send({ image: imageData })
  }
}
