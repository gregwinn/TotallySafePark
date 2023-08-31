import Rails from "@rails/ujs"
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-validation"
export default class extends Controller {
    static targets = [ "form", "output" ]
    static values = { url: String }


    handleChange(event) {
        let input = event.target
        Rails.ajax({
            url: this.urlValue,
            type: 'post',
            data: new FormData(this.formTarget),
            success: (data) => {
                this.outputTarget.innerHTML = data
                input = document.getElementById(input.id)
                this.moveCursorToEnd(input)
            }
        })
    }

    moveCursorToEnd(element) {
        if (typeof element.selectionStart == "number") {
            element.focus()
            element.selectionStart = element.selectionEnd = element.value.length;
        } else if (typeof element.createTextRange != "undefined") {
            element.focus()
            var range = element.createTextRange()
            range.collapse(false)
            range.select()
        }
    }
}
