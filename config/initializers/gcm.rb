::GCM_INSTANCE = GCM.new(Rails.application.secrets.gcm_sender_id)
