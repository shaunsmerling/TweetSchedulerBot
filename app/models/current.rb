#class you use in requests to assign things e.g. user, timezone, account type 
#keeps everything seperated, allows you to define things that need to be shared throughout the application
class Current < ActiveSupport::CurrentAttributes
    attribute :user
end  