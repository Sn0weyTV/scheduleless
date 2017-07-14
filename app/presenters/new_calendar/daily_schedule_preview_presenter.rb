module NewCalendar
  class DailySchedulePreviewPresenter
    def initialize(date: Date.today, location:, user:)
      @date = date
      @location = location
      @user = user
    end

    def shift_view_width_class
      "shifts day-length-#{day_length}"
    end

    def shifts
      @_shifts ||= find_shifts.map do |shift|
        ShiftPresenter.new(shift: shift,
                           manage: true,
                           day_start: first_shift.minute_start)
      end
    end

    def users
      @_users ||= shifts.map do |shift|
        shift.user
      end
    end

    private

    attr_reader :date, :location, :user

    def day_length
      day_end - day_start
    end

    def day_end
      if last_shift.minute_start > last_shift.minute_end
        1440
      else
        last_shift.minute_end
      end
    end

    def day_start
      first_shift.minute_start
    end

    def first_shift
      find_shifts.first
    end

    def last_shift
      @_last_shift ||= LastShiftLocator.new(shifts: find_shifts).find
    end

    def find_shifts
      @_raw_shifts ||= scheduling_period.
        in_progress_shifts.
        where(date: date.to_s(:integer).to_i).
        includes(:user).
        order(:date, :minute_start)
    end

    def scheduling_period
      SchedulingPeriod.for(date, location)
    end
  end
end