angular.module('windoApp').directive('datePicker', function () {
  return {
    restrict: 'E',
    templateUrl: '/create/datepicker.html',
    controllerAs: 'datePicker',
    scope: {
      selectedDays: '=selectedDays'
    },
    controller: function ($scope) {
      var vm = this;

      // List of days for use of displaying day headers on the table.
      vm.days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

      // List of months for use of displaying the month on the header.
      vm.months = ['January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'];

      // Set up view-model variables.
      vm.today        = new Date(Date.now());
      vm.currMonth    = vm.today.getMonth();
      vm.currYear     = vm.today.getFullYear();
      vm.selectedDays = {};
      vm.outputDays   = $scope.selectedDays;

      // Initialize the current month on the calendar.
      changeMonth(vm.currYear, vm.currMonth);

      // ---------------------------------------------------------------------//
      // Select Day
      // When a user clicks a day's button on a calendar this function is
      // called. It will add the day to our object of days in this format:
      //    day.year.month.day = true   OR   day[year][month][day] = true
      // If the day was already selected (exists in the object and set to
      // true), then the day will be deleted from the object and therefore
      // "deselected".
      // ---------------------------------------------------------------------//
      vm.selectDay = function (day) {
        if (!vm.selectedDays[vm.currYear])
          vm.selectedDays[vm.currYear] = {};

        if (!vm.selectedDays[vm.currYear][vm.currMonth])
          vm.selectedDays[vm.currYear][vm.currMonth] = {};

        if (!vm.outputDays)
          vm.outputDays = {};
        var tempDate = new Date(vm.currYear, vm.currMonth, day);

        if (!vm.selectedDays[vm.currYear][vm.currMonth][day]) {
          vm.selectedDays[vm.currYear][vm.currMonth][day] = true;
          vm.outputDays[tempDate.getTime() / 1000] = [];
        }
        else {
          delete vm.selectedDays[vm.currYear][vm.currMonth][day];
          delete vm.outputDays[tempDate.getTime() / 1000];
        }

        console.log(vm.outputDays);
      }

      // ---------------------------------------------------------------------//
      // Is Today
      // Checks if the given day is the current day of the month. Used for
      // highlighting the current day on the calendar.
      // ---------------------------------------------------------------------//
      vm.isToday = function (day) {
        return vm.currMonth == vm.today.getMonth() && day == vm.today.getDate();
      }

      // ---------------------------------------------------------------------//
      // Inc Month (Increase Month)
      // When the user clicks the right arrow next to the month/year title
      // this function gets called and increments the current month by one and
      // updates the calendar accordingly.
      // ---------------------------------------------------------------------//
      vm.incMonth = function () {
        var newMonth = vm.currMonth + 1;
        var newYear = vm.currYear;

        if (newMonth > 11) {
          newMonth = 0;
          newYear++;
        }

        changeMonth(newYear, newMonth);
      }

      // ---------------------------------------------------------------------//
      // Dec Month (Decrease Month)
      // When the user clicks the left arrow next to the month/year title
      // this function gets called and decrements the current month by one and
      // updates the calendar accordingly.
      // ---------------------------------------------------------------------//
      vm.decMonth = function () {
        var newMonth = vm.currMonth - 1;
        var newYear = vm.currYear;

        if (newMonth < 0) {
          newMonth = 11;
          newYear--;
        }

        changeMonth(newYear, newMonth);
      }

      // ---------------------------------------------------------------------//
      // Change Month
      // Changes the month displayed on the calendar. This function will update
      // the daySlots variable to include the new set of days for the given
      // month. The view is modeled to the vm.daySlots and so when it Changes
      // the view will automatically change.
      // ---------------------------------------------------------------------//
      function changeMonth(year, month) {
        // Set firstDay to the first day of the month
        var firstDay = new Date(year, month, 1);

        // Update the current month and year in our view-model
        vm.currMonth = month;
        vm.currYear = year;

        // Initialize a 6 row by 7 column grid for days, setting all to 0.
        daySlots = [];
        for (var row = 0; row < 6; row++) {
          daySlots[row] = [];
          for (var col = 0; col < 7; col++)
            daySlots[row][col] = 0;
        }

        // Loop through the first row (week 1) in the array to start the input of days.
        for (var col = firstDay.getDay(); col < 7; col++) {
          daySlots[0][col] = firstDay.getDate();
          firstDay.setDate(firstDay.getDate() + 1);
        }

        // Loop through the remainder of the rows (weeks) in the array to set the dates.
        for (var row = 1; row < 6; row++) {
          for (var col = 0; col < 7; col++) {
            if (firstDay.getDate() == 1) {
              // Remove any unused rows so display will be neater.
              if (col == 0)
                daySlots = daySlots.slice(0, row);
              continue;
            }
            daySlots[row][col] = firstDay.getDate();
            firstDay.setDate(firstDay.getDate() + 1);
          }
        }

        // Set the view-model's daySlots to the temporary one we made.
        vm.daySlots = daySlots;
      }
    }
  }
});
