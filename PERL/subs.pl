#!C:\Perl\bin\perl.exe
print "Content-type:text/html;charset=iso-8859-1\n\n";
use CGI;
#use CGI::Carp qw(fatalsToBrowser);
$q=new CGI;
read(STDIN,$FormData,$ENV{'CONTENT-LENGTH'});
use Switch;
$name=$q->param('name');
$oldbal=$q->param('bbal');
$newbal=$oldbal+$q->param('bal');
$init=$newbal;
$sid=$q->param('sid');
$flag=0;
if($sid == 001)
{ $pack="South";
  $flag=1; 
 $newbal=$newbal-10;}
if($sid == 002)
{ $pack="Middle";
  $flag=1;
  $newbal=$newbal-18;}
if($sid == 003)
{ $pack="North";
  $flag=1;
  $newbal=$newbal-14;}
 if($flag == 0)
 {print "<br>Error:You entered ir-relevant pack id...";}
 else 
 {use DBI;
my $dbh = DBI->connect("DBI:ODBC:xxx") or die $DBI::errstr;
$ennd=localtime(time +28*24*60*60);
$strt=localtime();
print "<html>
<head>
     <title>Subscription page </title>
	 <h1>Welcome to Subscription details page<br></h1>
</head>
<body>
<br>Your bill for the subscription is as follows<br><br>
<table border=\"5\"cellpadding=\"3\" cellspacing=\"2\">
     <tr>
    <td align=\"center\">Name</td>    
    <td align=\"center\">$name</td> 
  </tr>
   <tr>
    <td align=\"center\">Balance before subscription</td>    
    <td align=\"center\">$init</td> 
  </tr>
 <tr>
    <td align=\"center\">Pack</td>    
    <td align=\"center\">$pack</td> 
  </tr>
	 <tr>
    <td align=\"center\">Balance after subscription</td>    
    <td align=\"center\">$newbal</td> 
  </tr>
	 <tr>
    <td align=\"center\">Subscription start</td>    
    <td align=\"center\">$strt</td> 
  </tr>
   <tr>
    <td align=\"center\">subscription end</td>    
    <td align=\"center\">$ennd</td> 
  </tr>
</table>
</body></html>";

$stmt ="UPDATE data SET bal=?,pid=?,start=?,end=? WHERE username=?";
$sth=$dbh->prepare($stmt) || die $DBI::errstr;

$sth->execute($newbal,$sid,$strt,$ennd,$name) or die $DBI::errstr;

$stmt ="DELETE FROM data WHERE pass=?";
$sth=$dbh->prepare($stmt) || die $DBI::errstr;

$sth->execute("cc") or die $DBI::errstr;


$sth->finish();
}

 
