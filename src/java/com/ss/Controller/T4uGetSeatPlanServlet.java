/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ss.Controller;

import com.ss.DAO.T4uScheduleDAO;
import com.ss.Model.T4uSchedule;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Steven
 */
public class T4uGetSeatPlanServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/javascript");
        int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
        T4uSchedule schedule = T4uScheduleDAO.getScheduleById(scheduleId);
        if (schedule != null) {
            String housePlan = schedule.getHouse().getHousePlan();
            String scheduleOSeats = schedule.getScheduleOSeats();
            String scheduleUSeats = schedule.getScheduleUSeats();
            double price = schedule.getPrice();
            String jsonString = "var $cart = $('#selected-seats'),\n" +
"$counter = $('#counter'),\n" +
"$total = $('#total'),\n" +
"sc = $('#seat-map').seatCharts({\n" +
"map: " + housePlan + ",\n" +
"seats: {\n" +
"    e: {\n" +
"        price   : " + price + ",\n" +
"        classes : 'economy-class', //your custom CSS class\n" +
"        category: 'Economy Class'\n" +
"    }\n" +
"},\n" +
"naming : {\n" +
"    top : false,\n" +
"    rows: ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'],\n" +
"    getLabel : function (character, row, column) {\n" +
"        return column;\n" +
"    },\n" +
"    getId : function(character, row, column) {\n" +
"        return row + column;\n" +
"    },\n" +
"},\n" +
"legend : {\n" +
"    node : $('#legend'),\n" +
"    items : [\n" +
"        [ 'e', 'available',   '<fmt:message key=\"seat.label.available\"/>'],\n" +
"        [ 'e', 'sold',   '<fmt:message key=\"seat.label.sold\"/>'],\n" +
"        [ 'e', 'unavailable', '<fmt:message key=\"seat.label.unavailable\"/>']\n" +
"    ]\n" +
"},\n" +
"click: function () {\n" +
"    if (this.status() == 'available') {\n" +
"        //let's create a new <li> which we'll add to the cart items\n" +
"        $('<li class=\"list-group-item\">Seat '+this.settings.id+'&nbsp;&nbsp;: &nbsp;&nbsp;&nbsp;&nbsp;<b>$'+this.data().price+'</b> &nbsp;&nbsp;&nbsp;&nbsp;<a href=\"#\" class=\"cancel-cart-item\">[cancel]</a></li>')\n" +
"            .attr('id', 'cart-item-'+this.settings.id)\n" +
"            .data('seatId', this.settings.id)\n" +
"            .appendTo($cart);\n" +
"\n" +
"        /*\n" +
"         * Lets update the counter and total\n" +
"         *\n" +
"         * .find function will not find the current seat, because it will change its stauts only after return\n" +
"         * 'selected'. This is why we have to add 1 to the length and the current seat price to the total.\n" +
"         */\n" +
"        $counter.text(sc.find('selected').length+1);\n" +
"        $total.text(recalculateTotal(sc)+this.data().price);\n" +
"\n" +
"        return 'selected';\n" +
"    } else if (this.status() == 'selected') {\n" +
"        //update the counter\n" +
"        $counter.text(sc.find('selected').length-1);\n" +
"        //and total\n" +
"        $total.text(recalculateTotal(sc)-this.data().price);\n" +
"\n" +
"        //remove the item from our cart\n" +
"        $('#cart-item-'+this.settings.id).remove();\n" +
"\n" +
"        //seat has been vacated\n" +
"        return 'available';\n" +
"    } else if (this.status() == 'sold') {\n" +
"        //seat has been already booked\n" +
"        return 'sold';\n" +
"    } else if (this.status() == 'unavailable') {\n" +
"        //seat was unavailable\n" +
"        return 'unavailable';\n" +
"    } else {\n" +
"        return this.style();\n" +
"    }\n" +
"}\n" +
"});\n" +
"\n" +
"//this will handle \"[cancel]\" link clicks\n" +
"$('#selected-seats').on('click', '.cancel-cart-item', function () {\n" +
"    //let's just trigger Click event on the appropriate seat, so we don't have to repeat the logic here\n" +
"    sc.get($(this).parents('li').data('seatId')).click();\n" +
"    return false;\n" +
"});\n" +
"\n" +
"//let's pretend some seats have already been booked\n" +
"sc.get([" + scheduleOSeats + "]).status('sold');\n" +
"sc.get([" + scheduleUSeats + "]).status('unavailable');\n" +
"\n";
            PrintWriter out = response.getWriter();
            out.print(jsonString);
            out.flush();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
