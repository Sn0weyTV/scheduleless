module MobileApi
  class FutureShiftsController < ApiAuthenticatedController
    def show
      future_shifts = ShiftFinder.for(current_user).future

      render json: { future_shifts: future_shifts }, status: :ok
    end
  end
end
