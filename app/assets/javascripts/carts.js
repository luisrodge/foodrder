var cart = (function () {
    // Toggle CartFragment delivery to true or false when on Cart show page
    var toggleDelivery = function (elem, event) {
        var checked = event.target.checked;
        var cfId = $(elem).attr("data-cf-id");

        console.log(event.target.checked);
        console.log($(elem).attr("data-cf-id"));

        $.ajax({
            type: "PUT",
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            url: "/cart_fragments/" + cfId,
            data: {delivery: checked},
            success: function () {
                console.log("CF delivery updated!");
            },
            error: function (data) {
                console.log("Cf failed update");
            }
        })

    };
    return {
        toggleDelivery: toggleDelivery
    }
})();