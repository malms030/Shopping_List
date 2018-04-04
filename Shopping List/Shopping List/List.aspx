<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="stylesheet" type="text/css" href="css/List.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div id="freqitems">
            <asp:label runat="server" ID="labelfreqitems"/>
            <b id="freqitemsTitle">Frequent Items</b>
            <br />
        </div>
        <br/>
        <div id="list_items">
            <asp:label runat="server" ID="labellistitems"/>
            <b id="itemsTitle">My Shopping List</b>
            <br />
        </div>
        <br />
        <br />
        <div id="options">
            <asp:LinkButton runat="server" ID="signoutButton" Text="Sign Out" PostBackURL="Login.aspx" />
        </div>
            
    </form>
</body>
</html>
