import Rails from "@rails/ujs/lib/assets/compiled/rails-ujs";
import sweetAlert from "sweetalert2";

const confirmed = (element, result) => {
  if (result.value) {
    // User clicked confirm button
    element.removeAttribute("data-confirm-swal");
    element.click();
  }
};

// Display the confirmation dialog
const showConfirmationDialog = element => {
  const message = element.getAttribute("data-confirm-swal");

  sweetAlert
    .fire({
      title: message || "Are you sure?",
      icon: "warning",
      width: 500,
      padding: "3em",
      showCancelButton: true,
      confirmButtonText: "Yes",
      cancelButtonText: "Cancel"
    })
    .then(result => confirmed(element, result));
};

const allowAction = element => {
  if (element.getAttribute("data-confirm-swal") === null) {
    return true;
  }

  showConfirmationDialog(element);
  return false;
};

function handleConfirm(element) {
  if (!allowAction(this)) {
    Rails.stopEverything(element);
  }
}

// Add event listener before the other Rails event listeners like the one
// for `method: :delete`
Rails.delegate(document, "a[data-confirm-swal]", "click", handleConfirm);
Rails.delegate(document, "input[data-confirm-swal]", "click", handleConfirm);

Rails.start();
