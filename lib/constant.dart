const apiKey = '';
const blogId = '';

const baseURL = 'https://www.googleapis.com/blogger/v3/blogs/$blogId';

const blogInfoURL = baseURL + '?key=' + apiKey;
const postsURL = baseURL + '/posts?key=' + apiKey ;

// ----- Errors -----
const serverError = 'Server error';
const somethingWentWrong = 'Something went wrong, try again!';


