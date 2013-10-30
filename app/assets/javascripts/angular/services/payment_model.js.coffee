window.app.service 'paymentsModel', ['$http', ($http)->

  this.getPayments = ($scope, page)->
    $http(method: "GET", url: "/agent_payments.json?page=#{page}&per_page=#{$scope.pagination.per_page}").success (data)->
      $scope.body = data.agent_payments
      $scope.pagination = data.pagination
      step = (step == undefined) ? 1 : step
      input = []
      for i in [1 .. $scope.pagination.total_pages]
        input.push(i)
      $scope.pagination.total_pages =  input;
  ###
  this.processPayment = ($scope, index, value)->
    $http( method: "PUT", url: "/agent_payments/#{value}/?format=json").success (data)->
      $.each $scope.body, (i, v)->
        if v.id == value
          $scope.body[i] = data
  ###

  this.confirmationPayment = ($scope, index, value)->
    $http( method: "PUT", url: "/agent_payments/#{value}/confirmation").success (data)->
      $.each $scope.body, (i, v)->
        if v.id == value
          $scope.body[i] = data

  this.processingPayment = ($scope, index, value)->
    $http( method: "PUT", url: "/agent_payments/#{value}/processing").success (data)->
      $.each $scope.body, (i, v)->
        if v.id == value
          $scope.body[i] = data

  this.selectedCls = ($scope, column)->
    column == $scope.sort.column && 'sort-' + $scope.sort.descending;


  this.changeSorting = ($scope, column)->
    sort = $scope.sort
    if sort.column == column
      sort.descending = !sort.descending;
    else
      sort.column = column;
      sort.descending = false;
]