import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
    static  values = {
        status: Boolean,
    }
    connect() {
        if (this.statusValue) {
            this.show()
            setTimeout(() => {
                this.hide()
            }, 5000)
        }
    }

    hide() {
        $("#toast_notification").fadeOut("slow")
    }

    show() {
        $("#toast_notification").fadeIn("slow")
    }
}

