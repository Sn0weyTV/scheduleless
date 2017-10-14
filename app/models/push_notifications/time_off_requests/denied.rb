module PushNotifications
  module TimeOffRequests
    class Denied < Base
      def initialize(user:, time_off_request:)
        @user = user
        @time_off_request = time_off_request
      end

      def message
        I18n.t("models.push_notifications.#{translation_key}.message",
               dates: time_off_request.label)
      end

      private

      attr_reader :user, :time_off_request

      def translation_key
        "time_off_requests.denied"
      end
    end
  end
end
