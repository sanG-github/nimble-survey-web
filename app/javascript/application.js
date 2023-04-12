import Rails from '@rails/ujs';
import * as ActiveStorage from '@rails/activestorage';

import 'core-js/stable';

import './translations/translations';

import './initializers/';
import './screens/';

Rails.start();
ActiveStorage.start();
