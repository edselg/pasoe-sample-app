/*global alert, $, progress, require */

// require("@progress/jsdo");

$(function () {
    'use strict';
    var serviceURI = "https://PUBLIC_IP_ADDRESS:8811/Sports";
    var catalogURI = serviceURI + "/static/SportsService.json";

    function createGrid() {
        console.log("DEBUG: createGrid(): ");
        $('#grid').kendoGrid({
            dataSource: {
                serverFiltering: false,
                serverSorting: false,
                serverPaging: false,
                type: "jsdo",
                transport: {
                    jsdo: "Customer"
                },
                error: function (e) {
                    var messages = "";
                    if (e.errorThrown) {
                        messages += e.errorThrown.message + "\n";
                    }
                    e.sender.transport.jsdo.getErrors().forEach(function (err) {
                        messages += err.error + "\n";
                    });
                    alert("Error: \n" + messages);
                }
            },
            selectable: "multiple row",
            navigatable: true,
            filterable: true,
            height: 400,
            groupable: true,
            reorderable: true,
            resizable: true,
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: true,
                pageSize: 10,
                buttonCount: 5
            },
            editable: 'inline',
            toolbar: ['create'],
            columns: [
                {
                    field: 'CustNum',
                    title: 'Cust Num',
                    width: 100
                },
                {field: 'Name'},
                {field: 'State'},
                {field: 'Country'},
                {command: ['edit', 'destroy'], title: '&nbsp;', width: '250px'}
            ]
        });
    }

    try {
        // Create a new session object
        progress.data.getSession({
            serviceURI: serviceURI,
            catalogURI: catalogURI,
            authenticationModel: "anonymous"
        }).then(function (/* jsdosession, result, info */) {
            createGrid();
        }, function (/* jsdosession, result, info */) {
            alert("Error while creating session.");
        });
    } catch (e) {
        alert("Error instantiating objects: " + e);
    }
});
