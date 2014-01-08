window.app.directive "ngConfirmClick", ->
  priority: 1
  terminal: true
  link: (scope, element, attr) ->
    msg = attr.ngConfirmClick
    clickAction = attr.ngClick
    element.bind "click", (event) ->
      event.preventDefault()
      scope.$eval clickAction if window.confirm(msg)