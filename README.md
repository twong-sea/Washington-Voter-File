Objectives:

* Turn VRDB (WA Voter File or wavf) into multiple tables.
	* `wavf` - voterid, name, dob, address etc.
		* Append census block or (bg) after geocoding vAddress
	* `vote_history` - voterid, election\_date, ballot\_return\_date