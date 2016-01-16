var myApp = angular.module('myApp', ['ngRoute', 'ngResource']);

myApp.config(function($routeProvider){

});

myApp.controller("mainController", function($scope, $http, $location){

    $scope.shopperAssignments = [];
    $scope.availableShoppers =  [];
    $scope.availableStores = [];
    $scope.availableOrders = [];
    $scope.isLoading = false;
    $scope.apiStatusMessage = null;                 // Message object displayed when loading or saving shopper assignment fails or succeeds.
    $scope.firstTimeLoad = true;                    // True when displaying the initial loading view

    /*********************************************************************************************
     * Functions for saving and loading shopper assignments from rails api
     *********************************************************************************************/
    var initializeAssignments = function(){
        $http({
            method: 'GET',
            url: $location.absUrl().split('?')[0] + "/api",
        }).then(function successCallback(response) {

            //console.log(response.data);

            $scope.firstTimeLoad = false;
            $scope.deliveryDate = response.data.assignment_collection.delivery_date;
            $scope.createdAtDate = response.data.assignment_collection.created_at;
            $scope.updatedAtDate = response.data.assignment_collection.updated_at;
            $scope.shopperAssignments = response.data.assignment_collection.shopper_assignments;
            $scope.availableShoppers = response.data.available_shoppers;
            $scope.availableStores = response.data.available_stores;
            $scope.availableOrders = response.data.available_orders;
        }, function errorCallback(response) {
            $scope.apiStatusMessage = {header: "Error", message: "Error loading page with status code: " + response.status}
        });

    }();

    $scope.onAssignmentsSave = function(){

        console.log({shopper_assignments: $scope.shopperAssignments})

        $scope.isLoading = true;

        $http({
            method: 'POST',
            url: $location.absUrl().split('?')[0],
            data: {shopper_assignments: $scope.shopperAssignments}
        }).then(function successCallback(response) {
            $scope.isLoading = false;
            $scope.apiStatusMessage = {header: "Success", class: 'success', message: "Shopper assignment successfully saved."}
        }, function errorCallback(response) {
            $scope.isLoading = false;
            $scope.apiStatusMessage = {header: "Error", class: 'warning', message: "Failed to save shopper assignment. Http status code " + response.status}
        });
    };

    $scope.onStatusMessageDismiss = function(){
        $scope.apiStatusMessage = null;
    };

    /*********************************************************************************************
     * Functions for constructing and removing assignments
     *********************************************************************************************/

    $scope.onShopperSelected = function(shopper){
        if(!shopperAssignmentExists(shopper)){
            $scope.shopperAssignments.push({shopper: shopper, store_assignments: [], order_assignments: [] });
        }
    };

    // Remove ENTIRE shopper assignment for shopper
    $scope.onAssignmentRemove = function(index){
        $scope.shopperAssignments.splice(index, 1);
    };

    // Remove store assignment for shopper
    $scope.onStoreAssignmentRemove = function(index, assignment){
        assignment.store_assignments.splice(index, 1);
    };

    // Remove store assignment for shopper
    $scope.onOrderAssignmentRemove = function(index, assignment){
        assignment.order_assignments.splice(index, 1);
    };

    // Remove order assignment for shopper
    $scope.onStoreSelected = function(store, assignment){
        if(assignment.store_assignments.indexOf(store) < 0){
            assignment.store_assignments.push(store);
        }
    };

    // Remove order assignment for shopper
    $scope.onOrderSelected = function(order, assignment){
        if(assignment.order_assignments.indexOf(order) < 0){
            assignment.order_assignments.push(order);
        }
    };

    /*********************************************************************************************
     * Utility functions
     *********************************************************************************************/
    var shopperAssignmentExists = function(shopper){
        for(i = 0; i < $scope.shopperAssignments.length; i++){
            if($scope.shopperAssignments[i].shopper == shopper){
                return true;
            }
        }
        return false;
    };

});
