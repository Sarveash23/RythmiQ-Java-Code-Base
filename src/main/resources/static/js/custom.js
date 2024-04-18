






























$(document).ready(function() {
    // Attach the event listener to all input fields with the class 'numericInput'
    $('.numericInput').on('input', function() {
        // Get the current value of the input field
        var inputValue = $(this).val();

        // Remove non-numeric characters using a regular expression
        var numericValue = inputValue.replace(/[^0-9]/g, '');

        // Set the cleaned numeric value back to the input field
        $(this).val(numericValue);
    });

    $('.decimalInput').on('input', function() {
        // Get the current value of the input field
        var inputValue = $(this).val();

        // Remove non-numeric and non-decimal characters using a regular expression
        var decimalValue = inputValue.replace(/[^0-9.]/g, '');

        // Ensure there's only one decimal point
        decimalValue = decimalValue.replace(/(\..*)\./g, '$1');

        // Set the cleaned decimal value back to the input field
        $(this).val(decimalValue);
    });
    $('.letterInput').on('input', function() {
        // Get the current value of the input field
        var inputValue = $(this).val();

        // Remove non-numeric and non-decimal characters using a regular expression
        var decimalValue = inputValue.replace(/[^a-zA-Z ]/g, '');

        // Ensure there's only one decimal point
        decimalValue = decimalValue.replace(/(\..*)\./g, '$1');

        // Set the cleaned decimal value back to the input field
        $(this).val(decimalValue);
    });

    $('.letterNumberInput').on('input', function() {
        // Get the current value of the input field
        var inputValue = $(this).val();
        // Remove non-numeric and non-decimal characters using a regular expression
        var decimalValue = inputValue.replace(/[^a-zA-Z 0-9]/g, '');
        // Ensure there's only one decimal point
        decimalValue = decimalValue.replace(/(\..*)\./g, '$1');

        // Set the cleaned decimal value back to the input field
        $(this).val(decimalValue);
    });
    $('.phoneInput').on('input', function() {
        // Get the current value of the input field
        var inputValue = $(this).val();

        // Remove non-numeric and non-decimal characters using a regular expression
        var decimalValue = inputValue.replace(/[^0-9+]/g, '');

        // Ensure there's only one decimal point
        decimalValue = decimalValue.replace(/(\..*)\./g, '$1');

        // Set the cleaned decimal value back to the input field
        $(this).val(decimalValue);
    });    $('.phoneInput').on('input', function() {
        // Get the current value of the input field
        var inputValue = $(this).val();

        // Remove non-numeric and non-decimal characters using a regular expression
        var decimalValue = inputValue.replace(/[^0-9+]/g, '');

        // Ensure there's only one decimal point
        decimalValue = decimalValue.replace(/(\..*)\./g, '$1');

        // Set the cleaned decimal value back to the input field
        $(this).val(decimalValue);
    });
});