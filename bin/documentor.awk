BEGIN{
	IGNORECASE=1;
	
	arrProperty[0]="";
	arrPublicVar[0]="";
	arrPrivateVar[0]="";
	arrPublicMethod[0]="";
	arrPrivateMethod[0]="";
}
# *** Properties
/^[ \t]*(static)? *Property /{
	print "Property =====> " $0;
	
	next;	#Next File Record
}
# *** Public Variable
/^[ \t]*(static)? *public / && !/(function|sub|procedure)/{
	print "Public Variable =====> " $0;
	
	next;	#Next File Record
}
# *** Private Variable
/^[ \t]*(static)? *private / && !/(function|sub|procedure)/{
	print "Private Variable =====> " $0;
	
	next;	#Next File Record
}
# *** Public Methods
/^[ \t]*(static)? *public (function|sub|procedure) /{
	print "PUBLIC =====> " $0;
	
	next;	#Next File Record
}
# *** Private Methods
/^[ \t]*(static)? *(private)? *(function|sub|procedure) /{
	print "PRIVATE =====> " $0;
	
	next;	#Next File Record
}
{
	print $0;
}
END{
	
}