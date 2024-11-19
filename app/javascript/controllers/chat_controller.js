import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ["video", "canvas", "chat", "chatroom", "chatInput"]

  connect() {
    // console.log(this.roomId)
    this.startWebcam()
    this.createSubscription()
    // setTimeout(() => {
    //   this.capture()
    // }, 4000)
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
    this.roomId = this.generateRoomId()
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", room_id: this.roomId },
      {
        received: this._received.bind(this)
      }
    )
  }

  _received(data) {

    this.chatroomTarget.innerHTML += `<div>ALBERT: ${data}</div>`
  }

  generateRoomId() {
    return Math.random().toString(36).substring(2, 6)
  }

  capture() {
    const canvas = this.canvasTarget
    const context = canvas.getContext("2d")
    canvas.width = this.videoTarget.videoWidth
    canvas.height = this.videoTarget.videoHeight
    context.drawImage(this.videoTarget, 0, 0, canvas.width, canvas.height)

    const imageData = canvas.toDataURL("image/jpeg")
    this.channel.send({ image: imageData })
  }

  sendMessage() {
    // this.chatTarget.innerHTML
    console.log(this.chatInputTarget.value)
  }
}
