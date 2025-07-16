# FayInterview App - Julie Childress Submission

Thank you for checking out my app! It was fun to work on, and I would love any and all feedback on my implementations. Thank you!!

## Video Recording

I showed the app off in the first 3 minutes but I wanted to add some extra time to go over some areas of the code!

https://github.com/user-attachments/assets/ef3141bf-4573-4bcd-bce4-fa3dae2edeb9

## Time Tracker

These are very much estimates. I've included below a more detailed breakdown of how I spent my time, but I still wasn't 100% accurate as I would need to pause for personal matters from doing this outside of my normal working hours.

Estimates include: UI implementations, API implementations and tests

- Login screen: 3 hours
- Appointments screen: 10 hours
- Nice-to-haves: 3 hours
    - French support
    - Dark mode support
    - Animations + Welcome screen
- Any additional time spent: 1 hour
    - Planning + video recording

## Assumptions (A) + Questions (Q)

### API

- **A:** Backend translates the strings they send (i.e. "Follow up")

### Design

- **A:** Some icons are very similar to existing SFSymbols (i.e. profile icon, camera icon). I have implemented this project using the provided icons in Figma, but I would love to ask Design if we could use the SFSymbols instead as they benefit immediately from Apple's system optimizations (i.e. out-of-the-box accessibility, decreased app size).
- **Q:** Calendars on the Appointment Cards have a Radius of 3.6 - could we bump this to 4 to get it on a consistent standard? I've implemented for 3.6 as I cannot reach out to design and want to match UI 1:1. 
- **Q:** Design works really well in English with 3 characters guaranteed for every month, but other languages have more than 3 letters in their month abbreviation (i.e. French as shown in app). I would have questions for Design with the calendar icon: should the date expand left-to-right and lose its square shape but maintain its list size, or should it expand the entire icon, thereby keeping its square shape but expanding the list item? I've implemented the former.

### Navigation

- **A:** The current implementation I have does not have a NavigationStack as there was no need for one with the current requirements. However, from the Designs, most likely a NavigationStack would be needed in the future. This can exist at the `RootView` so Navigation is centralized, and States could be initialized with an `AppRouter` that contains the path for the NavigationStack. Then, states would just need to pass to the `AppRouter` a hashable enum (`i.e. enum AppRoute: Hashable`) to present new Views. 

## Time Tracker - Extended

### Thursday Evening
- Strategizing & Setup: ~1 hour
    - Thought of initial UI implementation for Appointments Screen
    - Imported colors and icons from Figma
    - Downloaded and imported Manrope font from GoogleFonts
    - Created standard APIClient & KeychainService implementations
    - Created standard DesignSystem implementations

- Implementing Base UI for AppointmentsView: ~3.5 hours
    - Created AppointmentsView
    - Implemented AppointmentsHeaderView (could this be reused for Chat/Journal/Profile? If so, would be better to move up to HomeView to be reused amongst all Views)
    - Implemented AppointmentsTabView (Upcoming | Past)
    - Implemented AppointmentsCardScrollView
        - Implemented LoadingView while Fetching Appointments
        - Implemented Basic AppointmentCardView (needs touch-ups/finalization)
    - Implemented AppointmentsState as @Observable object for AppointmentsView
    - Implemented some AppointmentsIntent enum cases
    - Added DesignTokens to DesignSystem while developing each Component of AppointmentsView
    - Next Steps: 
        - Finish AppointmentCardView (i.e. add Join Appointment button when required)
        - Create HomeView for Bottom Tab Bar
        - Implement API for Appointments & Plugin

### Friday Morning (Before Work)
- UI + Basic API: ~1.5 hours
    - Worked on AppointmentCardView/ScrollView to clean up and fix some issues from night before.
    - Created `Appointment` to be used by UI
    - Created `AppointmentAPIResponse` to be used on Data-side

### Saturday Morning
- Appointments UI: ~2 hours
    - Finalized UI for CardView and List
    - Finished localization and implemented French translations
    - Implemented fixes for Accessibility concerns
- API for Appointments: ~2 hours
    - Created specific APIClient for /appointments
    - Parsed response for /appointments
    - Sorted and formatted response for /appointments
    - Implemented fetching /appointments request on LoadingView being shown
    - Implemented updating state with response from API

### Sunday
- Home UI: ~2 hours
- Home API: ~1 hour
- TODO:
    - Add animation or transition view
    - Confirm physical keyboard behavior
    - Double check dark mode + localizations + accessibility

### Tuesday
- Welcome View + Animations between Views in RootView: ~1 hour
- Clean up/nice-to-haves: ~2 hours
    - Double checked UI implementations and updated one
    - Backfilled tests
    - Supported Accessibility + VoiceOver
    - Completed French support

### Wednesday
- Final Tweaks/Sanity Checks
- Recorded Video 🥳
