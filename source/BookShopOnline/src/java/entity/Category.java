package entity;
// Generated May 6, 2018 1:09:40 PM by Hibernate Tools 4.3.1



/**
 * Category generated by hbm2java
 */
public class Category  implements java.io.Serializable {


     private int categoryID;
     private String categoryName;

    public Category() {
    }

	
    public Category(int categoryID) {
        this.categoryID = categoryID;
    }
    public Category(int categoryID, String categoryName) {
       this.categoryID = categoryID;
       this.categoryName = categoryName;
    }
   
    public int getCategoryID() {
        return this.categoryID;
    }
    
    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }
    public String getCategoryName() {
        return this.categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }




}


