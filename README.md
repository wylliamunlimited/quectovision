# QuectoVision

A taste of future healthcare :P

Demo:
Apologies for my sick voice as I am really sick when I recorded this :(
https://github.com/wylliamunlimited/quectovision/assets/113057252/9e550e62-00ec-4a0d-b50b-541bf922fd08



Datasets:
- https://springernature.figshare.com/collections/A_dataset_of_simulated_patient-physician_medical_interviews_with_a_focus_on_respiratory_cases/5545842/1
  License: https://creativecommons.org/publicdomain/zero/1.0/ 


<!-- # Start of the permission_handler configuration
    target.build_configurations.each do |config|
      # xcconfig_path = config.base_configuration_reference.real_path
      # xcconfig = File.read(xcconfig_path)
      # xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      # File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }

      # You can enable the permissions needed here. For example to enable camera
      # permission, just remove the `#` character in front so it looks like this:
      #
      # ## dart: PermissionGroup.camera
      # 'PERMISSION_CAMERA=1'
      #
      #  Preprocessor definitions can be found at: https://github.com/Baseflow/flutter-permission-handler/blob/master/permission_handler_apple/ios/Classes/PermissionHandlerEnums.h
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: [PermissionGroup.calendarWriteOnly, PermissionGroup.calendar (iOS 16 and below)]
        # 'PERMISSION_EVENTS=1',
   
        ## dart: [PermissionGroup.calendarFullAccess, PermissionGroup.calendar (iOS 17 and above)]
        # 'PERMISSION_EVENTS_FULL_ACCESS=1',
  
        ## dart: PermissionGroup.reminders
        # 'PERMISSION_REMINDERS=1',

        ## dart: PermissionGroup.contacts
        # 'PERMISSION_CONTACTS=1',

        ## dart: PermissionGroup.camera
        # 'PERMISSION_CAMERA=1',

        ## dart: PermissionGroup.microphone
        'PERMISSION_MICROPHONE=1'

        ## dart: PermissionGroup.speech
        # 'PERMISSION_SPEECH_RECOGNIZER=1',

        ## dart: PermissionGroup.photos
        # 'PERMISSION_PHOTOS=1',

        ## dart: [PermissionGroup.location, PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]
        # 'PERMISSION_LOCATION=1',

        ## dart: PermissionGroup.notification
        # 'PERMISSION_NOTIFICATIONS=1',

        ## dart: PermissionGroup.mediaLibrary
        # 'PERMISSION_MEDIA_LIBRARY=1',

        ## dart: PermissionGroup.sensors
        # 'PERMISSION_SENSORS=1',

        ## dart: PermissionGroup.bluetooth
        # 'PERMISSION_BLUETOOTH=1',

        ## dart: PermissionGroup.appTrackingTransparency
        # 'PERMISSION_APP_TRACKING_TRANSPARENCY=1',

        ## dart: PermissionGroup.criticalAlerts
        # 'PERMISSION_CRITICAL_ALERTS=1'
      ]

    end


    <key>NSMicrophoneUsageDescription</key>
	<string>microphone</string> -->
