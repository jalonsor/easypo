#!/bin/gawk -f

function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s; }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s; }
function trim(s) { return rtrim(ltrim(s)); }

BEGIN{
	IGNORECASE=1;
	
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

# *** Public or Private Constants
/^[ \t]*(public|private) +const /{
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
	
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	nSplit=split(strDec, arr, /([Aa][Ss]|=)/);
	strDataType=trim(arr[2]);
	strDefVal=trim(arr[nSplit]);
	strAccess=$1;
	#strVarType=$2;
	strName=$3;
	
	strDoc="\n\n''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@MEMBERTYPE:Constant\n";	#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@ACCESS:" strAccess "\n";			#Private, Public
	strDoc=strDoc "''@VARTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@DATATYPE:" strDataType "\n";	#Byte, Integer, Object ...
	strDoc=strDoc "''@DEFVAL:" strDefVal "\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record	
}

# *** Properties ReadOnly
/^[ \t]*(static)? *property read /{
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
		
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	nSplit=split(strDec, arr, /([Aa][Ss]|=)/);
	strDataType=trim(arr[2]);
	strDefVal="";
	
	if(match($1, /static/)>0) strVarType=trim($1);
	strAccess="Public";
	if(length(strVarType)==0)
		strName=$3;
	else
		strName=$4;
		
	strDoc="\n\n''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@MEMBERTYPE:Property ReadOnly\n";	#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@ACCESS:" strAccess "\n";			#Private, Public
	strDoc=strDoc "''@VARTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@DATATYPE:" strDataType "\n";	#Byte, Integer, Object ...
	strDoc=strDoc "''@DEFVAL:" strDefVal "\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record
}

# *** Properties ReadWrite
/^[ \t]*(static)? *property /{
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
		
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	nSplit=split(strDec, arr, /([Aa][Ss]|=)/);
	strDataType=trim(arr[2]);
	strDefVal="";
	
	if(match($1, /static/)>0) strVarType=trim($1);
	strAccess="Public";
	if(length(strVarType)==0)
		strName=$2;
	else
		strName=$3;
		
	strDoc="\n\n''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@MEMBERTYPE:Property ReadWrite\n";	#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@ACCESS:" strAccess "\n";			#Private, Public
	strDoc=strDoc "''@VARTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@DATATYPE:" strDataType "\n";	#Byte, Integer, Object ...
	strDoc=strDoc "''@DEFVAL:" strDefVal "\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record
}

# *** Public or Private Variable
/^[ \t]*(static)? *(public|private) / && !/(function|sub|procedure)/{
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
		
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	nSplit=split(strDec, arr, /([Aa][Ss]|=)/);
	strDataType=trim(arr[2]);
	strDefVal=trim(arr[nSplit]);
	
	if(match($1, /static/)>0) strVarType=trim($1);
	if(length(strVarType)==0)
	{
		strAccess=$1;
		strName=$2;
	}
	else
	{
		strAccess=$2;
		strName=$3;
	}
		
	strDoc="\n\n''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@MEMBERTYPE:Variable\n";	#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@ACCESS:" strAccess "\n";			#Private, Public
	strDoc=strDoc "''@VARTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@DATATYPE:" strDataType "\n";	#Byte, Integer, Object ...
	strDoc=strDoc "''@DEFVAL:" strDefVal "\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record
}

#~ # *** Public or Private Methods
/^[ \t]*(static)? *(public|private) +(function|sub|procedure) /{
	#Static Public Function utilSplit(str As String, strSep As String, Optional notEnclosedIn As String[] = Null) As String[] ''Return Value: 	An Element object, which represents the created Element node
	
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
	strParams="";
	strAuxParams="";
	arrAuxParams["count"]="";
	
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	if(match(strDec, /\(.*\)/)>0)
	{
		strAuxParams=trim(substr(strDec, RSTART+1, RLENGTH-2));
		if(strAuxParams!="...")
		{
			nSplitParams=split(strDec, arrAuxParams, /, */);
			for(i=1;i<=nSplitParams;i++)
			{
				
				
			}
		}
		else
		{
				strParams="Variable Number of Parameters.";
		}
	}
	

	nSplit=split(strDec, arr, /([Aa][Ss]|=)/);
	strDataType=trim(arr[2]);
	strDefVal=trim(arr[nSplit]);
	
	if(match($1, /static/)>0) strVarType=trim($1);
	if(length(strVarType)==0)
	{
		strAccess=$1;
		strName=$2;
	}
	else
	{
		strAccess=$2;
		strName=$3;
	}
		
	strDoc="\n\n''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@MEMBERTYPE:Method\n";				#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@ACCESS:" strAccess "\n";			#Private, Public
	strDoc=strDoc "''@VARTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@RETURNTYPE:" strDataType "\n";	#Byte, Integer, Object ...
	strDoc=strDoc "''@PARAM:" strParams "\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record
}
#~ {
	#~ print $0;
#~ }
#~ END{
	
#~ }