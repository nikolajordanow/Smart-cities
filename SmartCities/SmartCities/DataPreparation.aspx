<%@ Page Title="Data preparation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DataPreparation.aspx.cs" Inherits="SmartCities.DataPreparation" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container body-content">

        <h2><%: Title %></h2>

        <asp:Button runat="server" ID="btnGenerateCustomers" Text="Generate customers" OnClick="btnGenerateCustomers_Click" />
        <asp:Button runat="server" ID="btnGenerateTraffic" Text="Generate traffic" OnClick="btnGenerateTraffic_Click" />
    </div>
</asp:Content>
