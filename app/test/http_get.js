import http from 'k6/http';
import {sleep} from 'k6';

// Load configuration
const config = JSON.parse(open('./config.json'));

export const options = {
    // Key configurations for Soak test in this section
    stages: [
        { duration: '1m', target: 100 }, // traffic ramp-up from 1 to 100 users over 1 minute
        { duration: '5m', target: 100 }, // stay at 100 users for 5 minutes
        { duration: '1m', target: 0 }, // ramp-down to 0 users
    ],
};

export default () => {
    const urlRes = http.get(config.attack_url);
    sleep(1);
    // MORE STEPS
    // Here you can have more steps or complex script
    // Step1
    // Step2
    // etc.
};
