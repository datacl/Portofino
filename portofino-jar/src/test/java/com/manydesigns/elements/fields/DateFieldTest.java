/*
 * Copyright (C) 2005-2014 ManyDesigns srl.  All rights reserved.
 * http://www.manydesigns.com/
 *
 * Unless you have purchased a commercial license agreement from ManyDesigns srl,
 * the following license terms apply:
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as published by
 * the Free Software Foundation.
 *
 * There are special exceptions to the terms and conditions of the GPL
 * as it is applied to this software. View the full text of the
 * exception in file OPEN-SOURCE-LICENSE.txt in the directory of this
 * software distribution.
 *
 * This program is distributed WITHOUT ANY WARRANTY; and without the
 * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/licenses/gpl.txt
 * or write to:
 * Free Software Foundation, Inc.,
 * 59 Temple Place - Suite 330,
 * Boston, MA  02111-1307  USA
 *
 */

package com.manydesigns.elements.fields;

import com.manydesigns.elements.AbstractElementsTest;
import com.manydesigns.elements.Mode;
import com.manydesigns.elements.annotations.DateFormat;
import com.manydesigns.elements.reflection.ClassAccessor;
import com.manydesigns.elements.reflection.JavaClassAccessor;
import com.manydesigns.elements.reflection.PropertyAccessor;
import com.manydesigns.elements.servlet.MutableHttpServletRequest;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import java.util.Date;
import java.util.TimeZone;

/*
* @author Paolo Predonzani     - paolo.predonzani@manydesigns.com
* @author Angelo Lupo          - angelo.lupo@manydesigns.com
* @author Giampiero Granatella - giampiero.granatella@manydesigns.com
* @author Alessio Stalla       - alessio.stalla@manydesigns.com
*/
public class DateFieldTest extends AbstractElementsTest {
    public static final String copyright =
            "Copyright (c) 2005-2014, ManyDesigns srl";

    private DateField dateField;

    @DateFormat("yyyy-MM-dd")
    public Date date;

    public void testDSTSwitch() {
        TimeZone.setDefault(TimeZone.getTimeZone("it"));
        setupFields(Mode.EDIT);
        MutableHttpServletRequest request = new MutableHttpServletRequest();

        //Compatibility
        String strDate = "1973-06-02";
        request.setParameter("date", strDate);
        dateField.readFromRequest(request);
        assertTrue(dateField.validate());
        dateField.writeToObject(this);
        DateTime dateTime = DateTimeFormat.forPattern("yyyy-MM-dd").parseDateTime(strDate);
        assertEquals(new DateTime(date.getTime()), dateTime);
        System.out.println(date);

        //Daylight saving test
        strDate = "1973-06-03";
        request.setParameter("date", strDate);
        dateField.readFromRequest(request);
        assertTrue(dateField.validate());
        dateField.writeToObject(this);
        DateTime test = new DateTime(date.getTime());
        assertEquals(1973, test.getYear());
        assertEquals(6, test.getMonthOfYear());
        assertEquals(3, test.getDayOfMonth());
        assertEquals(1, test.getHourOfDay());
        assertEquals(0, test.getMinuteOfHour());
        assertEquals(0, test.getSecondOfMinute());

        assertEquals(73, date.getYear());
        assertEquals(5, date.getMonth());
        assertEquals(2, date.getDate());
        assertEquals(23, date.getHours());
        assertEquals(0, date.getMinutes());
        assertEquals(0, date.getSeconds());
        System.out.println(date);

        //Compatibility
        strDate = "1973-06-04";
        request.setParameter("date", strDate);
        dateField.readFromRequest(request);
        assertTrue(dateField.validate());
        dateField.writeToObject(this);
        dateTime = DateTimeFormat.forPattern("yyyy-MM-dd").parseDateTime(strDate);
        assertEquals(new DateTime(date.getTime()), dateTime);
        System.out.println(date);
    }

    private void setupFields(Mode mode) {
        ClassAccessor classAccessor =
                JavaClassAccessor.getClassAccessor(this.getClass());
        try {
            PropertyAccessor myPropertyAccessor =
                    classAccessor.getProperty("date");
            dateField = new DateField(myPropertyAccessor, mode, null);

        } catch (NoSuchFieldException e) {
            e.printStackTrace();
            fail();
        }
    }
}
