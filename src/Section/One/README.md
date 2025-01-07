Lets review the artifacts!

1. Type signatures for both the editable and the validated version of a Person. I believe I have shown this.

2. Key function *signatures* involved in translating an editable version of a Person to a validated Person. Do not worry about implementing these. Done, except I implemented a couple of trivial functions because it would have hurt my soul not to.

3. Briefly describe the Module organization for these types and what should be exposed and what should be hidden. Be ready to discuss how this impacts total system maintainability

Alright, so basically I have made all of my module exports explicit, which should demonstrate what should be exposed and should be hidden. As per the module organization, I have all of section one code underneath the `Section.One` prefix. All of it is data, so I added a `Data` prefix. For pieces of data that are connected to a specific piece of data within this prefix (i.e. `SSN`) I have placed them under the SSN folder and prefix (for example. `Section.One.Person.SSN.AreaNumber`). This makes it very clear what corresponds with what, I think.


