BEGIN{
	IGNORECASE=1;
	
	arrPublicConst[0]="";
	arrPrivateConst[0]="";
	arrPropertyRead[0]="";
	arrProperty[0]="";
	arrPublicVar[0]="";
	arrPrivateVar[0]="";
	arrPublicMethod[0]="";
	arrPrivateMethod[0]="";
	
	swInfoFilename=0; # 0--> No filename info proccesed. 1--> Filename info proccesed.
}
FILENAME !="" && swInfoFilename==0{
	# *** Filename processed
	print "Filename processed =====> " FILENAME;	
	swInfoFilename=1;	#Filename info proccesed.
}
# *** Public Constants
/^[ \t]*public +const /{
	print "Public Constants =====> " $0;
	
	next;	#Next File Record	
}
# *** Private Constants
/^[ \t]*private +const /{
	print "Private Constants =====> " $0;
	
	next;	#Next File Record
}
# *** Properties ReadOnly
/^[ \t]*(static)? *property read /{
	print "Property ReadOnly =====> " $0;
	
	next;	#Next File Record
}
# *** Properties
/^[ \t]*(static)? *property /{
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
/^[ \t]*(static)? *public +(function|sub|procedure) /{
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