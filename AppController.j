/*
 * AppController.j
 * CPSearchFieldExample
 *
 * Created by Szabolcs Toth on February 17, 2012.
 * Copyright 2012, purzelbaum.hu All rights reserved.
 */

@import <Foundation/CPObject.j>


@implementation AppController : CPObject
{
    CPSearchField searchField;
    CPArray contacts;
    JSObject objsToDisplay;
    CPTableView myList;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // main window
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    contacts = ["Andy1", "Andy12", "Andy123", "Bjorn","Camille"];
    objsToDisplay = contacts;
    // creating scrollview
    var scrollView = [[CPScrollView alloc] initWithFrame: CGRectMake(100,100,330,300)];

    // creating tableview
    myList = [[CPTableView alloc] initWithFrame: CGRectMakeZero()];

    // creating column in the table
    var nameColumn = [[CPTableColumn alloc] initWithIdentifier:@"name" ];
    [[nameColumn headerView] setStringValue:@"Name"];
    [nameColumn setWidth:300];

    [myList addTableColumn: nameColumn];
    [myList setDataSource: self];
    [myList setDelegate: self];

    [scrollView setBorderType: CPBezelBorder];
    [scrollView setDocumentView: myList];

    // searchfield
    searchField = [[CPSearchField alloc] initWithFrame: CGRectMake(100,50,320,30)];
    [searchField setEditable: YES];
    [searchField setPlaceholderString:@"What are you looking for?"];
    [searchField setBordered: YES];
    [searchField setBezeled: YES];
    [searchField setFont:[CPFont systemFontOfSize: 12.0]];
    [searchField setTarget: self];
    [searchField setAction:@selector(searchChanged:)];
    [searchField setSendsWholeSearchString: NO];

    [contentView addSubview: scrollView];
    [contentView addSubview: searchField];
    [theWindow orderFront:self];

    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}

- (int) numberOfRowsInTableView: (CPTableView)aTableView
{
    return [objsToDisplay count];
}

-(id) tableView:(CPTableView)aTableView objectValueForTableColumn: (CPTableColumn)aColumn row:(int)rowIndex
{

    return [objsToDisplay objectAtIndex: rowIndex];
}

-(void) searchChanged:(id)sender
{
    if (sender)
        searchString = [[sender stringValue] lowercaseString];

    if(searchString)
        objsToDisplay = [];
        var count = 0;
        for(var i = 0; i < contacts.length; i++)
              if([[contacts objectAtIndex:i] lowercaseString].match(searchString))
               {
                objsToDisplay[count] = contacts[i];
                count++;
                }

    [myList reloadData];
}

@end
