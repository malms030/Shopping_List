<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    public string userid;


    void Page_Load()
    {
         if (Session.IsNewSession)
        {
            Response.Redirect("Login.aspx");
        }
        else if(Session["isAuthenticated"].ToString() == "yes")
        {
            form1.Visible = true;
        }
        else if(Session["isAuthenticated"].ToString() == "no" || Session["isAuthenticated"] == null)
        {
            Response.Redirect("Login.aspx");
        }

    }
    protected void tryclose(object o, EventArgs e)
    {

    }
    protected void removeBtn_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in grdItems.Rows)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                if (chkRow.Checked)
                {
                    string userid = Request.Cookies["UserID"].Value;
                    System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                    string sqlremove = "DELETE FROM list_items WHERE id = @id AND item_name = @name;";
                    string sqladdrecent = "insert into recent_items (id, item_name, description) values (@id, @name, @notes)";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlremove, sqlConnStr);
                    System.Data.SqlClient.SqlCommand cmd2 = new System.Data.SqlClient.SqlCommand(sqladdrecent, sqlConnStr);
                    cmd.Parameters.Add("@id", System.Data.SqlDbType.Int);
                    cmd.Parameters["@id"].Value = userid;
                    cmd.Parameters.Add("@name", System.Data.SqlDbType.VarChar, 100);
                    cmd.Parameters["@name"].Value = row.Cells[1].Text;
                    cmd2.Parameters.AddWithValue("@id",userid);
                    cmd2.Parameters.AddWithValue("@name", row.Cells[1].Text);
                    cmd2.Parameters.AddWithValue("@notes", row.Cells[5].Text);
                    cmd2.Connection.Open();
                    cmd2.ExecuteNonQuery();
                    cmd2.Connection.Close();
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                    grdItems.DataBind();
                    

                }
          }
        Response.Redirect("List.aspx");  }
        catch(System.Data.SqlClient.SqlException ex)
        {

        }
    }
    protected void addBtn_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if ((item.Text == "") || (qty.Text == ""))
            {
                item.BorderColor = System.Drawing.Color.Red;
                qty.BorderColor = System.Drawing.Color.Red;
            }
            else
            {
                System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                string sqlinsert = "insert into list_items (id, item_name, qty, store, dept, description) values (@id, @item, @qty, @store, @dept, @notes)";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
                cmd.Parameters.AddWithValue("@id", Request.Cookies["UserID"].Value);
                cmd.Parameters.Add("@item", System.Data.SqlDbType.VarChar, 100);
                cmd.Parameters["@item"].Value = item.Text;
                cmd.Parameters.Add("@qty", System.Data.SqlDbType.Int);
                cmd.Parameters["@qty"].Value = qty.Text;
                cmd.Parameters.Add("@store", System.Data.SqlDbType.VarChar, 100);
                cmd.Parameters["@store"].Value = store.Text;
                cmd.Parameters.Add("@dept", System.Data.SqlDbType.VarChar, 50);
                cmd.Parameters["@dept"].Value = dept.Text;
                cmd.Parameters.Add("@notes", System.Data.SqlDbType.VarChar, 500);
                cmd.Parameters["@notes"].Value = notes.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                item.Text = "";
                qty.Text = "";
                store.Text = "";
                dept.Text = "";
                notes.Text = "";
                grdItems.DataBind();
                filter(new object(), new EventArgs());
                SortList1.DataBind();
                SortList2.DataBind();

            }
        }
        catch(System.FormatException ex) {
            item.BorderColor = System.Drawing.Color.Red;
            qty.BorderColor = System.Drawing.Color.Red;}


    }

    public void freqaddBtn_Click(object o, EventArgs e)
    {
        if (addfreq.Text == "")
        {
            addfreq.BorderColor = System.Drawing.Color.Red;
        }
        else
        {
            try
            {
                System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                string sqlinsert = "insert into freq_item (id, item_name, description) values (@id, @item, @description)";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
                cmd.Parameters.AddWithValue("@id", Request.Cookies["UserID"].Value);
                cmd.Parameters.AddWithValue("@item", addfreq.Text);
                cmd.Parameters.AddWithValue("@description", freqDesc.Text);
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("List.aspx");
                cmd.Connection.Close();
            }
            catch (System.FormatException ex)
            {
                addfreq.BorderColor = System.Drawing.Color.Red;
            }
        }
    }

    public void show_list(object o, EventArgs e)
    {
        form1.Visible = false;
        freqitemsform.Visible = true;
    }

    public void freqItemsRemove(object o, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in freqitems.Rows)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                if (chkRow.Checked)
                {
                    string userid = Request.Cookies["UserID"].Value;
                    System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                    string sqlremove = "DELETE FROM freq_item WHERE id = @id AND item_name = @name;";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlremove, sqlConnStr);
                    cmd.Parameters.Add("@id", System.Data.SqlDbType.Int);
                    cmd.Parameters["@id"].Value = userid;
                    cmd.Parameters.Add("@name", System.Data.SqlDbType.VarChar, 100);
                    cmd.Parameters["@name"].Value = row.Cells[1].Text;
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();


                }
            }
            Response.Redirect("List.aspx");}
        catch(System.Data.SqlClient.SqlException ex)
        {

        }
    }

    public void freqItemsUpdate(object o, EventArgs e)
    {
        System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
        string sqlupdate = "UPDATE freq_item SET last_purchase_date = GETDATE() WHERE id = @id";
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlupdate, sqlConnStr);
        cmd.Parameters.AddWithValue("@id", Request.Cookies["UserID"].Value);
        cmd.Connection.Open();
        cmd.ExecuteNonQuery();
        cmd.Connection.Close();
        Response.Redirect("List.aspx");

    }
    public void recentcancel_Click(object o, EventArgs e)
    {
        Response.Redirect("List.aspx");
    }
    public void recentadd_Click(object o, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in recentitems.Rows)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                if (chkRow.Checked)
                {
                    string userid = Request.Cookies["UserID"].Value;
                    System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                    string sqlqry = "insert into freq_item (id, item_name, description) values (@id, @item, @notes);";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlqry, sqlConnStr);
                    cmd.Parameters.AddWithValue("@id", userid);
                    cmd.Parameters.AddWithValue("@item", row.Cells[1].Text);
                    cmd.Parameters.AddWithValue("@notes", row.Cells[2].Text);
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();

                }
            }
            Response.Redirect("List.aspx");}
        catch (System.Data.SqlClient.SqlException ex)
        {


        }
    }
    public void pan1_Click(object o, EventArgs e)
    {
        if(Request.Cookies["hf1"].Value == "0") {  Request.Cookies["hf1"].Value = "1"; }
        else { Request.Cookies["hf1"].Value = "0"; }
    }
    public void pan2_Click(object o, EventArgs e)
    {
        if(Request.Cookies["hf2"].Value == "0") {  Request.Cookies["hf2"].Value = "1"; }
        else { Request.Cookies["hf2"].Value = "0"; }
        Response.Redirect("Login.aspx");
    }
    public void filter(object o, EventArgs e)
    {
        if(!(SortList1.Text == "") && !(SortList2.Text == ""))
        {
            regitems.SelectCommand = "SELECT item_name as Item, qty as QTY, store as Store, dept AS Dept, description as Notes from list_items where store ='"+SortList1.Text+"' and dept ='"+SortList2.Text+"' and id=@id;";
            grdItems.DataBind();
        }
        else if(!(SortList1.Text == "") && SortList2.Text == "")
        {
            regitems.SelectCommand = "SELECT item_name as Item, qty as QTY, store as Store, dept AS Dept, description as Notes from list_items where store ='"+SortList1.Text+"'and id=@id;";
            grdItems.DataBind();
        }
        else if(SortList1.Text=="" && !(SortList2.Text == ""))
        {
            regitems.SelectCommand = "SELECT item_name as Item, qty as QTY, store as Store, dept AS Dept, description as Notes from list_items where dept ='"+SortList2.Text+"'and id=@id;";
            grdItems.DataBind();
        }
    }
    public void ClearSortButton_Click(object o, EventArgs e)
    {
        Response.Redirect("List.aspx");
    }
    public void usermenu(object o, EventArgs e)
    {
        Response.Redirect("updateAccount.aspx");
    }
    public void logout(object o, EventArgs e)
    {
        Session["isAuthenticated"] = "no";
        Response.Redirect("Login.aspx");
    }
    public void loadhelp(object o, EventArgs e)
    {
        Response.Redirect("submitRequest.aspx");
    }
    public void storeloc_Click(object o, EventArgs e)
    {
        Response.Redirect("storeLocator.html");
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
    <title>Shopping List</title>
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
    <form id="form1" visible="false" runat="server">
        
       <div id="icons">
 
<img id="userBtn" src="Images/usericon.png" class="dropbtn" onclick="myFunction2()" />
<div class="dropdown">
  <div id="myDropdown2" class="dropdown-content" style="left:-40px; top:25px">
    <asp:LinkButton ID="home" OnClick="usermenu" text="Your Account" runat="server" />
    <asp:LinkButton ID="about" OnClick="logout" text="Sign Out" runat="server" />
  </div>
</div>           


<img id="settingsBtn" src="Images/settings.png" class="dropbtn" onclick="myFunction()" />
<div class="dropdown2">
  <div id="myDropdown" class="dropdown-content" style=" right:-100px; top:40px">
    <asp:LinkButton ID="help" OnClick="loadhelp" text="Help Request" runat="server" />
    <asp:LinkButton ID="storeloc" OnClick="storeloc_Click" text="Store Locator" runat="server" />
  </div>
</div>
           <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
           <br />
       </div>
        
<div id="container">
        
        <asp:HiddenField ID="hf1" Value="1" runat="server"/>
        <button class="accordion" name="pan1" onclick="pan1_Click" type="button">Frequent Items</button>
        <div id="frequentitems" class="panel">
            <br />
            <asp:label runat="server" ID="labelfreqitems"/>
             <asp:GridView
                id="freqitems"
                DataSourceID="freq_items_source"
                CellPadding="10" 
                border="0"
                GridLines="None"
                Runat="server">
                <EditRowStyle BackColor="brown" />
                <HeaderStyle CssClass="GridHeadertext" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>     
             </Columns>
            </asp:GridView>
            <asp:SqlDataSource
                id="freq_items_source"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT item_name as Item, description as Notes, CONVERT(VARCHAR(12), last_purchase_date, 107) 'Last Purchased' from freq_item where id = @id"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br \ />
            <div>
            <asp:Button ID="freqRemove" Text="Remove" OnClick="freqItemsRemove" runat="server" />
            <asp:Button ID="freqUpdate" Text="Update" OnClick="freqItemsUpdate" runat="server" />
            </div>
            <br \ />
            <div id ="freqitemsalign">
            <asp:TextBox runat="server" ID="addfreq" placeholder="Frequent Item" CssClass="Textbox" />
            <asp:TextBox runat="server" ID="freqDesc" placeholder="Notes" CssClass="TextboxLong2" />
            <asp:ImageButton ID="freqplus" ImageUrl="Images/add.png" OnClick="freqaddBtn_Click" runat="server" />
            <br \ />
            </div>
            <div id ="align_adjust">
            <asp:Button runat="server" ID="addfromlist" OnClick="show_list" Text="Add from Recent Items" />
            </div>
            <br \ />
            <br \ />

        </div>
         <br/>
        <br/>
        <asp:HiddenField ID="hf2" Value="1"  runat="server"/>
        <button class="accordion" id="pan2" onclick="pan2_Click" type="button">My Shopping List</button>
        <div id="list_items" class="panel">
            <asp:label runat="server" ID="labellistitems"/>
            <div id="sortmenues">
             <asp:Label ID ="filterlabel" Text="Filter:" runat="server" />
            <asp:dropdownlist ID="SortList1" runat="server" DataSourceID="SqlDataSourcedd1" DataTextField="Store"  DataValueField="store" OnSelectedIndexChanged="filter" CssClass="ddl">
                <asp:ListItem Enabled="true" Selected="True" Text=""></asp:ListItem>
            </asp:dropdownlist>
            <asp:dropdownlist ID="SortList2" runat="server" DataSourceID="SqlDataSourcedd2" DataTextField="Dept" DataValueField="dept" OnSelectedIndexChanged="filter" CssClass="ddl">
                 <asp:ListItem Enabled="true" Selected="True" Text=""></asp:ListItem>
            </asp:dropdownlist>
            <asp:button id="ClearSortButton" text="Clear" onclick="ClearSortButton_Click" runat="server"/> 
            <asp:button id="SortButton" text="Sort" onclick="filter" runat="server"/>
            
                </div>
            <asp:GridView
                id="grdItems"
                DataSourceID="regitems"
                CellPadding="10" 
                border="0"
                GridLines="None"
                Runat="server">
                <EditRowStyle BackColor="brown" />
                <HeaderStyle CssClass="GridHeadertext" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
             </Columns>
               
            </asp:GridView>
            
            <asp:Button runat="server" ID="gotit" OnClick="removeBtn_Click" Text="Got It!" />
            <br /><br />
            <br />
            <asp:SqlDataSource
                id="regitems"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT item_name as Item, qty as QTY, store as Store, dept AS Dept, description as Notes from list_items where id = @id"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource
                id="SqlDataSourcedd1"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT DISTINCT store FROM list_items WHERE id =@id;"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource
                id="SqlDataSourcedd2"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT DISTINCT dept FROM list_items WHERE id =@id;"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        
            <div id="add">
                <asp:TextBox runat="server" ID="item" placeholder="Item"  CssClass="Textbox" />
                <asp:TextBox runat="server" ID="qty" placeholder="Quantity" CssClass="Textbox" />
                <asp:TextBox runat="server" ID="store" placeholder="Store" CssClass="Textbox" />
                <asp:TextBox runat="server" ID="dept" placeholder="Department" CssClass="Textbox" />
                <asp:TextBox runat="server" ID="notes" placeholder="Notes" CssClass="TextboxLong" />
                <asp:ImageButton ID="addBtn" ImageUrl="Images/add.png" OnClick="addBtn_Click" runat="server" />
            </div>
            </div>

        </div>
        <br />
        <br />
            
    </form>

    <form id="freqitemsform" visible="false" runat="server">
        <div id="recentitemsbody">

           <asp:label runat="server" ID="labelrecent"/>
            <b id="recentitemsTitle">Add to Frequent Items:</b>
            <br />
            <br />
        <asp:GridView
                id="recentitems"
                DataSourceID="recent_items_source"
                CellPadding="10" 
                border="0"
                GridLines="None"
                Runat="server">
                <EditRowStyle BackColor="brown" />
                <HeaderStyle BackColor="SaddleBrown" />
                <HeaderStyle CssClass="Headertext" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>     
             </Columns>
            </asp:GridView>
            <asp:SqlDataSource
                id="recent_items_source"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT item_name as Item, description as Notes, CONVERT(VARCHAR(12), purchased, 107) 'Purchased On' from recent_items where id = @id"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
           <asp:Button runat="server"  ID="recentcancel" OnClick="recentcancel_Click" Text="Cancel" />
           <asp:Button runat="server" ID="recentadd" OnClick="recentadd_Click" Text="Add" />
           </div>  
        <br \ />
        <br\ />
    </form>

    <form id="storelocator" runat="server" visible="false">
    <span id="errormsg"></span>

    <input id="pac-input" class="controls" type="text" placeholder="Search Box"/>
    <div id="map"></div>

    </form>
    <script>
        // This example adds a search box to a map, using the Google Place Autocomplete
        // feature. People can enter geographical searches. The search box will return a
        // pick list containing a mix of places and predicted search terms.

        // This example requires the Places library. Include the libraries=places
        // parameter when you first load the API. For example:
        // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">
        var lat = 46.786671;
        var long = -92.100487;

        function initAutocomplete() {
            var lat = 46.786671;
            var long = -92.100487;


            var map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: lat, lng: long },
                zoom: 13,
                mapTypeId: 'roadmap'
            });


            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    var pos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };
                    map.setCenter(pos);
                }, function () {
                    handleLocationError(true, infoWindow, map.getCenter());
                });
            } else {
                // Browser doesn't support Geolocation
                handleLocationError(false, infoWindow, map.getCenter());
            }


            // Create the search box and link it to the UI element.
            var input = document.getElementById('pac-input');
            var searchBox = new google.maps.places.SearchBox(input);
            map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

            // Bias the SearchBox results towards current map's viewport.
            map.addListener('bounds_changed', function () {
                searchBox.setBounds(map.getBounds());
            });

            var markers = [];
            // Listen for the event fired when the user selects a prediction and retrieve
            // more details for that place.
            searchBox.addListener('places_changed', function () {
                var places = searchBox.getPlaces();

                if (places.length == 0) {
                    return;
                }

                // Clear out the old markers.
                markers.forEach(function (marker) {
                    marker.setMap(null);
                });
                markers = [];

                // For each place, get the icon, name and location.
                var bounds = new google.maps.LatLngBounds();
                places.forEach(function (place) {
                    if (!place.geometry) {
                        console.log("Returned place contains no geometry");
                        return;
                    }
                    var icon = {
                        url: place.icon,
                        size: new google.maps.Size(71, 71),
                        origin: new google.maps.Point(0, 0),
                        anchor: new google.maps.Point(17, 34),
                        scaledSize: new google.maps.Size(25, 25)
                    };

                    // Create a marker for each place.
                    markers.push(new google.maps.Marker({
                        map: map,
                        icon: icon,
                        title: place.name,
                        position: place.geometry.location
                    }));

                    if (place.geometry.viewport) {
                        // Only geocodes have viewport.
                        bounds.union(place.geometry.viewport);
                    } else {
                        bounds.extend(place.geometry.location);
                    }
                });
                map.fitBounds(bounds);
            });
        }

    </script>
    <script>
        var acc = document.getElementsByClassName("accordion");
        var i;
        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {
                this.classList.toggle("active");
                var panel = this.nextElementSibling;
                if (panel.style.display === "none") {
                    panel.style.display = "block";
                } else {
                    panel.style.display = "none";
                }
            });
        }
</script>

</body>
</html>
