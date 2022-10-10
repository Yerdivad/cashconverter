/*
 * Welcome to your app's main JavaScript file!
 *
 * We recommend including the built version of this JavaScript file
 * (and its CSS file) in your base layout (base.html.twig).
 */

// any CSS you import will output into a single css file (app.css in this case)
import './styles/app.css';

// start the Stimulus application
import './bootstrap';

// require jQuery normally
const $ = require('jquery');

// create global $ and jQuery variable
global.$ = global.jQuery = $;



$(function() {
    if (window.location.pathname === '/home'){
        getCategories()
    }

    if (window.location.pathname.indexOf('/category/') !== -1){
        runCategoryFormLogic();
    }
});

function runCategoryFormLogic(){
    workAroundAboutDependentsFields();
    checkFilledRequieredFields();
}

function workAroundAboutDependentsFields() {
    $('#marca').change(function () {
        let brand = parseInt($(this).val());
        let modelAttributes = JSON.parse($('#modelo')[0].dataset.options);

        $.each(modelAttributes,
            function (k, v) {
                if (parseInt(v.dependents) !== brand) {
                    $("#modelo option[value='" + v.id + "']").remove();
                }
            })
        $('#marca').prop("disabled", true);
        $('#modelo-field').fadeIn();
    });
}

function checkFilledRequieredFields() {
    $('input,select').change(function () {
        let numberOfInputsRequired = 0;
        let numberOfInputsFilled = 0;
        $('form#attributes').find('input,select').each(function () {
            if ($(this).prop('required')) {
                numberOfInputsRequired++;
            }
            if ($(this).prop('required') && parseInt($(this).val())) {
                numberOfInputsFilled++;
            }
        });

        if (numberOfInputsFilled === numberOfInputsRequired) {
            $('#save').prop("disabled", false);
        }
    });
}

function getCategories(){
    $.ajax({
        url: "/api/category-list"
    })
        .done(function( data ) {
            $.each(data.categories,
                function (k, v) {
                    $("#categories").append(`<li><a href="/category/${v.id}">${k}</a></li>`);
                    $("#loading").hide();
                    $("#categories").fadeIn();
                })
        });
}

