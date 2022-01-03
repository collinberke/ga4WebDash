# dateRangeFloorMonth() outputs UI element for a month

    Code
      dateRangeInput("x", start_date, label = "Select a date range:")
    Output
      <div id="x" class="shiny-date-range-input form-group shiny-input-container">
        <label class="control-label" id="x-label" for="x">Select a date range:</label>
        <div class="input-daterange input-group input-group-sm">
          <input class="form-control" type="text" aria-labelledby="x-label" title="Date format: yyyy-mm-dd" data-date-language="en" data-date-week-start="0" data-date-format="yyyy-mm-dd" data-date-start-view="month" data-initial-date="2021-01-15" data-date-autoclose="true"/>
          <span class="input-group-addon input-group-prepend input-group-append">
            <span class="input-group-text"> to </span>
          </span>
          <input class="form-control" type="text" aria-labelledby="x-label" title="Date format: yyyy-mm-dd" data-date-language="en" data-date-week-start="0" data-date-format="yyyy-mm-dd" data-date-start-view="month" data-date-autoclose="true"/>
        </div>
      </div>

