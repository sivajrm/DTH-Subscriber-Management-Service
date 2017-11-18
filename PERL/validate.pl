#!C:\Perl\bin\perl.exe
print "Content-type:text/html;charset=iso-8859-1\n\n";
use CGI;
use CGI::Carp qw(fatalsToBrowser);
$q=new CGI;
read(STDIN,$FormData,$ENV{'CONTENT-LENGTH'});
use Switch;

$name=$q->param('name');
$pass=$q->param('password');

#print $name;
#print $pass;
use DBI;

my $dbh = DBI->connect("DBI:ODBC:xxx") or die $DBI::errstr;
my $sth = $dbh->prepare("SELECT * FROM DATA");
$sth->execute() or die $DBI::errstr;
while (my @row = $sth->fetchrow_array()) {        
  if($name eq $row[0]){
  if($pass eq $row[1])
  {print "Your login has been successfull<BR><br>Welcome $name";
   print "
   <html>
  <head>
     <title>Profile page </title>
	 <h1>Welcome to profile view page</h1>
</head>
<body>
<FORM METHOD=\"post\" ACTION=\"http://127.0.0.1/cgi-bin/subs.pl\">
<table border=\"5\"cellpadding=\"3\" cellspacing=\"2\">
     <tr>
    <td align=\"center\">Name</td>    
    <td align=\"center\">$row[0]</td> 
  </tr>
  <tr>
    <td align=\"center\">Region</td>
    <td align=\"center\">$row[3]</td>
  </tr>
  <tr>
    <td align=\"center\">Phone</td>
    <td align=\"center\">$row[4]</td>
  </tr>
 <tr>
    <td align=\"center\">Balance</td>
    <td align=\"center\">$row[5]</td>
  </tr>
  <TR>
    <TD>Enter bal amount:</TD>
    <TD>
      <INPUT TYPE=\"number\" value=\"0\" NAME=\"bal\" SIZE=\"20\" required>
    </TD>
  </TR>
   <TR>
    <TD>Enter sub id:</TD>
    <TD>
      <INPUT TYPE=\"number\" value=\"0\" NAME=\"sid\" SIZE=\"20\" required>
    </TD>
  </TR>
  
      <INPUT TYPE=\"hidden\" value=\"$row[0]\" NAME=\"name\">
	  <INPUT TYPE=\"hidden\" value=\"$row[5]\" NAME=\"bbal\">
	  
</TABLE>
<button type=\"reset\" value=\"Reset\">Reset</button>
<P><INPUT TYPE=\"SUBMIT\" VALUE=\"Submit\" ></P>
</FORM>

</body>  
 </html> ";}
  else 
  {print "not successfull";}
  }
}
$sth->finish();
$dbh->commit or die $DBI::errstr;

