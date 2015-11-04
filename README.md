### Events Calendar

#### Problem description:

Design and build an interface to display events, given information as structured below. Any solution is valid – e.g. a javascript calendar widget, a beautifully formatted web page, a command line tool.

#### Usage:
Launch the rails server and navigate to http://localhost:port

#### Design and assumptions:

Events are loaded from a json data file included in the root directory of the app.

The json data file is parsed and the events are grouped by dates. The json data file is loaded as a Hash. The keys are dates and the values are array of events.
In a production system, there would be a way to choose a datasource or upload a data file.

Events for a particular day are displayed as links in the date cell. When a calendar day has more than 2 events, the events are bundled up into a single link such as "3 events".
