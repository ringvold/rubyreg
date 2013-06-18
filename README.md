RubyReg
========

Simple event registration/poll system written i Rails.

Have an events, trips, gatherings, meetups or similar that people needs to register for and you dont want to use a hosted service and rather host it yourself with ruby?  
Then RubyReg is for you! ;)

Note: For the moment it is limited to text fields, textarea and single checkboxes per field so the poll part is not completely there yet (yeah, needs some work). If you do a custom implementation of the form you still can use the system to store the value of radiobuttons or checkboxes but it cannot create or render those fields. You need to use a normal text field when you create it for now.


## Features
- Easy form builder UI
- Export to Excel
- Embed. Full form (via javascript. iframe can be implemented on request) or only basic javascript for custom implementation.
- Multiple users

### Planned

This list has no spesific prioritization so what ever is requested will probably be done first.
- Send email to registrants (if the form has a email field).
- Multiple checkbox/radio button per field. Kinda basic functionality.
- Improve how the form generated and rendered. Current implementation is very hacky.
- Full localization. Currently only partial implementation.

### Could do

- Multiple accounts (an accout has many user and events/registrations and is seperate form other accounts users and registratons)
- Graph representation of registrants? (more relevant for a poll functionality)
- ...any other ideas? Put it in the issues. :)

Some other things like defining a more consistend terminology (should it use event or registration, registrant og replyer?) also needs to be done.
The code also probably needs some cleanup.

## License

MIT License. Copyright 2012 Harald Ringvold. http://ringvold.nu
