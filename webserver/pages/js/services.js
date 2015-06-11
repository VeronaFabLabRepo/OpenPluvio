/*
file: services.js
description: Angularjs services for OpenPluvio project
authors: alberto valente <alberto@plumake.it>, davide grobberio <davide@plumake.it>
project: OpenPluvio an OpenSource tipping bucket rain gauge
version: 1.0
organization: Verona FabLab <www.veronafablab.it>
license: CC-BY-SA

*/

var opApp = angular.module('opApp.services', ["ngResource"]);

opApp.factory("Monthly_mm", ['$resource', function ($resource) {
    return $resource("/get_monthly_mm", {});
}]);
opApp.factory("Daily_mm", ['$resource', function ($resource) {
    return $resource("/get_daily_mm", {});
}]);