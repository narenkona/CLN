public without sharing class ActiveCoursesListController {
	@AuraEnabled
    public static List<Course__c> getActiveCourses() {
        List<Course__c> activeCoursesFromDb = [SELECT GADate__c, CleanAcronym__c, CLNURL__c, CourseNameFull__c, Version__c, BasePrice__c, DeliveryMethod__c, Technologies__c FROM Course__c WHERE Active__c = true AND EOLDate__c = null AND EOSDate__c = null];
        List<Course__c> activeCourses = new List<Course__c>();
        
        for (Course__c course : activeCoursesFromDb) {
            Course__c temp = new Course__c();
            temp.GADate__c = course.GADate__c;
            temp.CleanAcronym__c = course.CleanAcronym__c;
            
            if (course.CLNURL__c == null)
                temp.CLNURL__c = '.';
            else
                temp.CLNURL__c = course.CLNURL__c;
            
            temp.CourseNameFull__c = course.CourseNameFull__c;
            temp.DeliveryMethod__c = course.DeliveryMethod__c;
            temp.Version__c = course.Version__c;
            temp.BasePrice__c = course.BasePrice__c;
            temp.Technologies__c = course.Technologies__c;
            
            if (!contains(activeCourses, temp))
                activeCourses.add(temp);
        }
        
        return activeCourses;
    }
    
    @AuraEnabled
    public static List<Course__c> getEOLCourses() {
        List<Course__c> eolCoursesFromDb = [SELECT EOSDate__c, EOLDate__c, CleanAcronym__c, CLNURL__c, CourseNameFull__c, DeliveryMethod__c, Version__c, AlternateProduct__c FROM Course__c WHERE (EOLDate__c != null OR EOSDate__c != null)];
        List<Course__c> eolCourses = new List<Course__c>();
        
        for (Course__c course : eolCoursesFromDb) {
            Course__c temp = new Course__c();
            temp.EOSDate__c = course.EOSDate__c;
            temp.EOLDate__c = course.EOLDate__c;
            temp.CleanAcronym__c = course.CleanAcronym__c;
            
            if (course.CLNURL__c == null)
            	temp.CLNURL__c = '.';
            else
                temp.CLNURL__c = course.CLNURL__c;
            
            temp.CourseNameFull__c = course.CourseNameFull__c;
            temp.DeliveryMethod__c = course.DeliveryMethod__c;
            temp.Version__c = course.Version__c;
            temp.AlternateProduct__c = course.AlternateProduct__c;
            
            if (!contains(eolCourses, temp))
            	eolCourses.add(temp);
        }
        
        return eolCourses;
    }
    
    private static boolean contains(List<Course__c> cList, Course__c course) {
        for (Course__c c : cList) {
            if (course.EOSDate__c == c.EOSDate__c && course.EOLDate__c == c.EOLDate__c && course.CleanAcronym__c == c.CleanAcronym__c && course.DeliveryMethod__c == c.DeliveryMethod__c && course.CourseNameFull__c == c.CourseNameFull__c && course.Version__c == c.Version__c && course.AlternateProduct__c == c.AlternateProduct__c)
                return true;
        }
        
        return false;
    }
}