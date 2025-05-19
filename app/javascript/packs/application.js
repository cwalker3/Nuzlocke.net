import React from 'react';
import ReactDOM from 'react-dom';
import ReactRailsUJS from 'react_ujs';

// Load all files under app/javascript/components:
const componentRequireContext = require.context('../components', true);
ReactRailsUJS.useContext(componentRequireContext);
