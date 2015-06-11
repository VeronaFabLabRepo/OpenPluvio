/*
file: app.js
description: Angularjs app for OpenPluvio project
authors: alberto valente <alberto@plumake.it>, davide grobberio <davide@plumake.it>
project: OpenPluvio an OpenSource tipping bucket rain gauge
version: 1.0
organization: Verona FabLab <www.veronafablab.it>
license: CC-BY-SA

*/

var opApp = angular.module('opApp', ['ngResource','opApp.services']);

opApp.controller('opCtrl', ['$scope', '$log', 'Monthly_mm', 'Daily_mm', function ($scope, $log, Monthly_mm, Daily_mm) {

    $scope.drawMonthlyPlot = function () {
        Monthly_mm.get({mese:$('#mese_m').val(),anno:$('#anno_m').val()}, function (data) {
            monthly_chart.series[0].setData(data.basculate, true);
        }, function (data) {
            $log.debug("err"+data)
        });
    }
    
    $scope.drawDailyPlot = function () {
        Daily_mm.get({giorno:$('#giorno_d').val(),mese:$('#mese_d').val(),anno:$('#anno_d').val()}, function (data) {
            daily_chart.series[0].setData(data.basculate, true);
        }, function (data) {
            $log.debug("err"+data)
        });
    }

    monthly_chart = new Highcharts.Chart({
        chart: {
            type: 'column',
            style: {fontFamily: '\'Helvetica Neue\', Helvetica, Arial, sans-serif'},
            renderTo: 'openpluviograph_monthly', height: 450
        },
        title: {text: 'Precipitazioni giornaliere su base mensile', style: { "color": "#555555", "fontSize": "22px" }},
        xAxis: {
            categories: [' ','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31']
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Rainfall (mm)'
            }
        },
        tooltip: {
        formatter: function () {
            return '<b>Giorno:' + this.x + '</b><br/>' +
                 this.y + 'mm<br/>';
            }
        },
        series: [{
            name: 'Precipitazioni giornaliere'
        }]
    });//end chart
    
    daily_chart = new Highcharts.Chart({
        chart: {
            type: 'column',
            style: {fontFamily: '\'Helvetica Neue\', Helvetica, Arial, sans-serif'},
            renderTo: 'openpluviograph_daily', height: 450
        },
        title: {text: 'Precipitazioni orarie su base giornaliera', style: { "color": "#555555", "fontSize": "22px" }},
        xAxis: {
            categories: [' ','0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23']
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Rainfall (mm)'
            }
        },
        tooltip: {
        formatter: function () {
            return '<b>Ore:' + this.x + '</b><br/>' +
                 this.y + 'mm<br/>';
            }
        },
        series: [{
            name: 'Precipitazioni orarie'
        }]
    });//end chart
}]);