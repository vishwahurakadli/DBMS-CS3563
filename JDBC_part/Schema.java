import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Schema {

    // function to open database and clear and create tables
    public static void main(String args[]) {
        // first open database
        Connection c = null;
        try {
            Class.forName("org.postgresql.Driver");
            c = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5432/postgres",
                    "postgres",
                    "1231");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("Opened database successfully");

        // DROP all the table in database to not already exists error second run se
        // try {
        //     Statement stmt = c.createStatement();
        //     String sql = "DROP TABLE Research_Paper cascade;";
        //     stmt.executeUpdate(sql);
        //     sql = "DROP TABLE Author cascade;";
        //     stmt.executeUpdate(sql);
        //     sql = "DROP TABLE Conference cascade;";
        //     stmt.executeUpdate(sql);
        //     sql = "DROP TABLE written_by;";
        //     stmt.executeUpdate(sql);
        //     sql = "DROP TABLE cited_by;";
        //     stmt.executeUpdate(sql);
        //     System.out.println("DROP all the table in database...");
        // } catch (SQLException e) {
        //     e.printStackTrace();
        // }

        // for creating table of Conference
        try {
            Statement stmt = c.createStatement();
            String sql = "CREATE TABLE Conference " +
                    "(id INTEGER not NULL, " + // conference id bhi function genrated hogi
                    " Venue TEXT not NULL," + // venue data se jo mandatory hoga
                    " PRIMARY KEY ( id ))"; // primary key author id hogi
            stmt.executeUpdate(sql);
            System.out.println("Created Conference table in given database...");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // for creating table of Research_Paper
        try {
            Statement stmt = c.createStatement();
            String sql = "CREATE TABLE Research_Paper " +
                    "(id INTEGER not NULL, " + // paper id
                    " Title TEXT, " + // paper title
                    " YEAR INTEGER, " + // paper publishing year
                    " abstract TEXT, " + // paper abstract
                    " conference_id INTEGER, " + // paper abstract
                    " PRIMARY KEY ( id )," + // primary key paper id hogi
                    " FOREIGN KEY ( conference_id ) REFERENCES Conference(id))"; // primary key paper id hogi
            stmt.executeUpdate(sql);

            System.out.println("Created Research_Paper table in given database...");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // for creating table of Author
        try {
            Statement stmt = c.createStatement();
            String sql = "CREATE TABLE Author " +
                    "(id INTEGER not NULL, " + // author id jo function genrated hogi
                    " first_name VARCHAR(255) not NULL, " + // first name data se jo mandatory hoga
                    " middle_name VARCHAR(255), " + // middle name data se
                    " last_name VARCHAR(255), " + // last name data se
                    " PRIMARY KEY ( id ))"; // primary key author id hogi
            stmt.executeUpdate(sql);

            System.out.println("Created Author table in given database...");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // for creating table of written_by
        try {
            Statement stmt = c.createStatement();
            String sql = "CREATE TABLE written_by " +
                    "(paper_id INTEGER not NULL, " + // paper_id jo Research_Paper ke id se ayegi
                    " Author_id INTEGER not NULL, " + // Author_id jo name se ayegi or mandatory hogi
                    " Co_Author INTEGER, " + // Co_Author jab multiple hoga tho data repeat kareg
                    " PRIMARY KEY ( paper_id,Author_id )," + // primary key Research_Paper se aai hui paper_id hogi
                    " FOREIGN KEY ( paper_id ) REFERENCES Research_Paper(id)," + // primary key paper id hogi
                    " FOREIGN KEY ( Author_id ) REFERENCES Author(id))"; // primary key paper id hogi

            stmt.executeUpdate(sql);
            System.out.println("Created written_by table in given database...");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // for creating table of cited_by
        try {
            Statement stmt = c.createStatement();
            String sql = "CREATE TABLE cited_by " + // iss table mai primary key nahi rakh sakte
                    "(id INTEGER not NULL, " + // id jo Research_Paper ke id se ayegi agar cited hua hai tho
                    " cited_by INTEGER not NULL," + // cited_by jab multiple hoga tho data repeat karega
                    " FOREIGN KEY ( id ) REFERENCES Research_Paper(id))";
            stmt.executeUpdate(sql);
            System.out.println("Created cited_by table in given database...");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

