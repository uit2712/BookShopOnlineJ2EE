package entity;
// Generated May 25, 2018 11:12:04 PM by Hibernate Tools 4.3.1


import java.io.Serializable;

/**
 * Publisher generated by hbm2java
 */
public class Publisher  implements java.io.Serializable {


     private int publisherId;
     private Serializable publisherName;

    public Publisher() {
    }

    public Publisher(int publisherId, Serializable publisherName) {
       this.publisherId = publisherId;
       this.publisherName = publisherName;
    }
   
    public int getPublisherId() {
        return this.publisherId;
    }
    
    public void setPublisherId(int publisherId) {
        this.publisherId = publisherId;
    }
    public Serializable getPublisherName() {
        return this.publisherName;
    }
    
    public void setPublisherName(Serializable publisherName) {
        this.publisherName = publisherName;
    }




}

