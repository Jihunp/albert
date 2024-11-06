import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["video", "canvas"]

  connect() {
    this.startWebcam()
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

  capture() {
    const canvas = this.canvasTarget
    const context = canvas.getContext("2d")
    canvas.width = this.videoTarget.videoWidth
    canvas.height = this.videoTarget.videoHeight
    context.drawImage(this.videoTarget, 0, 0, canvas.width, canvas.height)
  }
}
