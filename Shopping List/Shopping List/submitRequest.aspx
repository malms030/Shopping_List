<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    public void submitButton_Click (object sender, EventArgs e)
    {

    }
</script>
<script type="text/javascript">
    function myFunction() {
        document.getElementById("myDropdown").classList.toggle("show");
    }

    function myFunction2() {
        document.getElementById("myDropdown2").classList.toggle("show");
    }

    // Close the dropdown if the user clicks outside of it
    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {

            var dropdowns = document.getElementsByClassName("dropdown-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List Submit a Help Request</title>
     <link rel="stylesheet" type="text/css" href="css/submitRequest.css"/>
     <link rel="stylesheet" type="text/css" href="css/List.css"/>
    <style>
        .dropdown {
    position: relative;
    display: inline-block;
}

.dropdown2 {
    position: absolute;
    padding-left: 358px;
    padding-top: 20px;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: saddlebrown;
    min-width: 160px;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: white;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown a:hover {background-color: #FFFAF0; color: black;
}
.dropdown2 a:hover {background-color: #FFFAF0; color: black;
}

.show {display:block;}

    </style>
</head>
<body>

     <div id="icons">
 
<img id="userBtn" src="Images/usericon.png" class="dropbtn" onclick="myFunction2()" />
<div class="dropdown">
  <div id="myDropdown2" class="dropdown-content" style="left:-40px; top:25px">
    <a href="#home">Update User Information</a>
    <a href="Login.aspx">Sign Out</a>
  </div>
</div>           


<img id="settingsBtn" src="Images/settings.png" class="dropbtn" onclick="myFunction()" />
<div class="dropdown2">
  <div id="myDropdown" class="dropdown-content" style=" right: -20px; top:40px">
    <a href="submitRequest.aspx">Submit Help Request</a>
    <a href="storeLocator.html">Store Locator</a>
  </div>
</div>
           <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
           <br />
       </div>


    <div id="requestDiv">

    <form id="form1" runat="server">
        <asp:label runat="server" ID="labelLogin">
           <br />
            <span id="spanSubject">Subject</span>
            <br />
            <asp:TextBox runat="server" ID="Subject" placeholder="Request Subject" required="required" CssClass="subject" />
            <br />
            <br />
            <span id="spanContent">Request</span>
            <br />
            <asp:TextBox runat="server" ID="Content" required="required" textmode="MultiLine" CssClass="content" />
            <br />
            <asp:Button runat="server" ID="reqSubmitButton" OnClick="submitButton_Click" Text="Submit" />
            <br />
            <br />
            <br />
            <span></span>
            <asp:LinkButton runat="server" ID="listDirectButton" Text="Back to List" PostBackUrl="List.aspx" />
        </asp:label>
    </form>
    </div>

</body>
</html>