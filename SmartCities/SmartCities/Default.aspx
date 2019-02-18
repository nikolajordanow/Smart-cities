<%@ Page Title="Traffic map" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SmartCities.Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="modal-body row">
        <div class="col-sm-2">
            <div>Select age:</div>
            <select id="ageSelector" multiple="multiple">
                <option value="1-18">1-18</option>
                <option value="19-25">19-25</option>
                <option value="26-35">26-35</option>
                <option value="36-45">36-45</option>
                <option value="46-65">46-65</option>
                <option value="66-100">66-100</option>
            </select>
            <div>Select gender:</div>
            <select id="genderSelector">
                <option value="M">M</option>
                <option value="F">F</option>
                <option value="?">?</option>
            </select>
            <div>
                <span>Min date:</span>
                <input type="text" class="form-control" id="minDate">
            </div>
            <div>
                <span>Max date:</span>
                <input type="text" class="form-control" id="maxDate">
            </div>
            <div>
                <br />
                <input type="button" id="btnSearchTraffic" value="Search" />
                <span>Count:</span>
                <span id="spCount" >0</span>
            </div>
        </div>
        <div class="col-sm-10">
            <div id="mapid"></div>
        </div>
    </div>
</asp:Content>
