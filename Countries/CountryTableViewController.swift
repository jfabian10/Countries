//
//  CountryTableViewController.swift
//  Countries
//
//  Created by CS3714 on 10/6/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//


import UIKit



class CountryTableViewController: UITableViewController {
    
    
    
    let tableViewRowHeight: CGFloat = 60.0
    
    
    
    // Alternate table view rows have a background color of MintCream or OldLace for clarity of display
    
    
    
    // Define MintCream color: #F5FFFA  245,255,250
    
    let MINT_CREAM = UIColor(red: 245.0/255.0, green: 255.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    
    
    
    // Define OldLace color: #FDF5E6   253,245,230
    
    let OLD_LACE = UIColor(red: 253.0/255.0, green: 245.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    
    
    
    /*
     
     The Countries.plist XML file represents a Dictionary data structure consisting of:
     
     Key = Country Code   Value = object reference of an Array containing the country data items
     
     */
    
    
    
    //---------- Create and Initialize the Dictionary -----------------
    
    
    
    var dict_Countrycode_Countrydata = [String: AnyObject]()
    
    
    
    //---------- Create and Initialize the Arrays ---------------------
    
    
    
    var countryCodes = [String]()
    
    var countryData  = [String]()
    
    
    
    // websiteURL and countryName will be passed to the downstream view controller
    
    var websiteURL: String = ""
    
    var countryName: String = ""
    
    
    
    /*
     
     -----------------------
     
     MARK: - View Life Cycle
     
     -----------------------
     
     */
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        // Obtain the URL of the Countries.plist file residing on a server computer
        
        let countriesFileURL: URL? = URL(string: "http://manta.cs.vt.edu/iOS/Countries.plist")
        
        
        
        // NSDictionary manages an *unordered* collection of key-value pairs. Instantiate an
        
        // NSDictionary object and initialize it with the contents of the Countries.plist file.
        
        let dictionaryFromFile: NSDictionary? = NSDictionary(contentsOf: countriesFileURL!)
        
        
        
        /*
         
         If the returned object reference of the newly created dictionary is nil, then the file on
         
         the server computer was not read in due to a problem, which may be (1) the iOS device has
         
         no network connection, (2) the file is misplaced, or (3) the server is down.
         
         */
        
        
        
        if let dictionaryForCountriesPlistFile = dictionaryFromFile {
            
            
            
            // Typecast the created dictionary of type NSDictionary as Dictionary type
            
            // and assign it to the class property
            
            dict_Countrycode_Countrydata = dictionaryForCountriesPlistFile as! Dictionary
            
            
            
            /*
             
             allKeys returns a new array containing the dictionary’s keys as of type AnyObject.
             
             Therefore, typecast the AnyObject type keys to be of type String.
             
             The keys in the array are *unordered*; therefore, they need to be sorted.
             
             */
            
            countryCodes = dictionaryForCountriesPlistFile.allKeys as! [String]
            
            
            
            // Sort the countryCodes within itself in alphabetical order
            
            countryCodes.sort { $0 < $1 }
            
            
            
            // print(dict_Countrycode_Countrydata)
            
            
            
        } else {
            
            
            
            // Unable to get the file from the server over the network
            
            showErrorMessageFor("Countries.plist")
            
            return
            
        }
        
        
        
    }
    
    
    
    /*
     
     -------------------------------------------
     
     MARK: - Show Alert Displaying Error Message
     
     -------------------------------------------
     
     */
    
    
    
    func showErrorMessageFor(_ fileName: String) {
        
        
        
        /*
         
         Create a UIAlertController object; dress it up with title, message, and preferred style;
         
         and store its object reference into local constant alertController
         
         */
        
        let alertController = UIAlertController(title: "Unable to Access the File: \(fileName)",
                                                
                                                message: "Possible causes: (a) No network connection, (b) Accessed file is misplaced, or (c) Server is down.",
                                                
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        // Create a UIAlertAction object and add it to the alert controller
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        
        
        // Present the alert controller by calling the presentViewController method
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    /*
     
     --------------------------------------
     
     MARK: - Table View Data Source Methods
     
     --------------------------------------
     
     */
    
    
    
    /*
     
     A Table View object (UITableView) consists of Sections.
     
     A Section consists of Rows.
     
     A Row contains one Cell object (UITableViewCell).
     
     A Cell object is configured with the UI objects (e.g., image, text, accessory icon) to create the look of a row.
     
     */
    
    
    
    // Asks the data source to return the number of sections in the table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        
        
        return 1
        
    }
    
    
    
    // Asks the data source to return the number of rows in a section, the number of which is given
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return countryCodes.count
        
    }
    
    
    
    /*
     
     ------------------------------------
     
     Prepare and Return a Table View Cell
     
     ------------------------------------
     
     */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        
        
        // Obtain the object reference of a reusable table view cell object instantiated under the identifier
        
        // CountryCellType, which was specified in the storyboard
        
        let cell: CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CountryCellType") as! CountryTableViewCell
        
        
        
        // Obtain the country code of the row
        
        let countryCode: String = countryCodes[rowNumber]
        
        
        
        cell.countryCodeLabel!.text = countryCode
        
        
        
        let countryDataArray: AnyObject? = dict_Countrycode_Countrydata[countryCode]
        
        
        
        countryData = countryDataArray! as! [String]
        
        
        
        let flagImageFileName = countryData[0]
        
        
        
        cell.flagImageView!.image = UIImage(named: flagImageFileName)
        
        
        
        cell.populationLabel!.text = countryData[1]
        
        cell.capitalLabel!.text = countryData[2]
        
        
        
        return cell
        
    }
    
    
    
    /*
     
     -----------------------------------
     
     MARK: - Table View Delegate Methods
     
     -----------------------------------
     
     */
    
    
    
    // Asks the table view delegate to return the height of a given row.
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        return tableViewRowHeight
        
    }
    
    
    
    /*
     
     Informs the table view delegate that the table view is about to display a cell for a particular row.
     
     Just before the cell is displayed, we change the cell's background color as MINT_CREAM for even-numbered rows
     
     and OLD_LACE for odd-numbered rows to improve the table view's readability.
     
     */
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /*
         
         The remainder operator (RowNumber % 2) computes how many multiples of 2 will fit inside RowNumber
         
         and returns the value, either 0 or 1, that is left over (known as the remainder).
         
         Remainder 0 implies even-numbered rows; Remainder 1 implies odd-numbered rows.
         
         */
        
        if (indexPath as NSIndexPath).row % 2 == 0 {
            
            // Set even-numbered row's background color to MintCream, #F5FFFA 245,255,250
            
            cell.backgroundColor = MINT_CREAM
            
            
            
        } else {
            
            // Set odd-numbered row's background color to OldLace, #FDF5E6 253,245,230
            
            cell.backgroundColor = OLD_LACE
            
        }
        
    }
    
    
    
    // Informs the table view delegate that the specified row is selected.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        
        
        // Obtain the country code of the row
        
        let countryCode: String = countryCodes[rowNumber]
        
        
        
        let countryDataArray: AnyObject? = dict_Countrycode_Countrydata[countryCode]
        
        
        
        countryData = countryDataArray! as! [String]
        
        
        
        performSegue(withIdentifier: "CountryMapView", sender: self)
        
    }
    
    
    
    // Informs the table view delegate that the user tapped the Detail Disclosure button
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        
        
        // Obtain the country code of the row
        
        let countryCode: String = countryCodes[rowNumber]
        
        
        
        let countryDataArray: AnyObject? = dict_Countrycode_Countrydata[countryCode]
        
        
        
        countryData = countryDataArray! as! [String]
        
        
        
        countryName = countryData[3]
        
        
        
        websiteURL = countryData[7]
        
        
        
        performSegue(withIdentifier: "CountryWebView", sender: self)
        
    }
    
    
    
    /*
     
     -------------------------
     
     MARK: - Prepare For Segue
     
     -------------------------
     
     */
    
    
    
    // This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
    
    // You never call this method. It is invoked by the system.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "CountryMapView" {
            
            
            
            // Obtain the object reference of the destination view controller
            
            let countryMapViewController: CountryMapViewController = segue.destination as! CountryMapViewController
            
            
            
            //Pass the data object to the destination view controller object
            
            countryMapViewController.countryData = countryData
            
            
            
        } else if segue.identifier == "CountryWebView" {
            
            
            
            // Obtain the object reference of the destination view controller
            
            let countryWebViewController: CountryWebViewController = segue.destination as! CountryWebViewController
            
            
            
            //Pass the data objects to the destination view controller object
            
            countryWebViewController.countryName = countryName
            
            countryWebViewController.websiteURL = websiteURL
            
        }
        
    }
    
    
    
}
    
