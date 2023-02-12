// https://openweathermap.org/weather-conditions
var iconNameByOwmCode = {
    '200': 'ios-thunderstorm-outline',
    '201': 'ios-thunderstorm-outline',
    '202': 'ios-thunderstorm-outline',
    '210': 'ios-thunderstorm-outline',
    '211': 'ios-thunderstorm-outline',
    '212': 'ios-thunderstorm-outline',
    '221': 'ios-thunderstorm-outline',
    '230': 'ios-thunderstorm-outline',
    '231': 'ios-thunderstorm-outline',
    '232': 'ios-thunderstorm-outline',
    
    '300': 'ios-drizzle-outline',
    '301': 'ios-drizzle-outline',
    '302': 'ios-drizzle-outline',
    '310': 'ios-drizzle-outline',
    '311': 'ios-drizzle-outline',
    '312': 'ios-drizzle-outline',
    '313': 'ios-drizzle-outline',
    '314': 'ios-drizzle-outline',
    '321': 'ios-drizzle-outline',
    
    '500': 'ios-rainy-outline',
    '501': 'ios-rainy-outline',
    '502': 'ios-rainy-outline',
    '503': 'ios-rainy-outline',
    '504': 'ios-rainy-outline',
    '511': 'ios-snow-outline',
    '520': 'ios-rainy-outline',
    '521': 'ios-rainy-outline',
    '522': 'ios-rainy-outline',
    '531': 'ios-rainy-outline',
    
    '600': 'ios-snow-outline',
    '601': 'ios-snow-outline',
    '602': 'ios-snow-outline',
    '611': 'ios-snow-outline',
    '612': 'ios-snow-outline',
    '613': 'ios-snow-outline',
    '615': 'ios-snow-outline',
    '616': 'ios-snow-outline',
    '620': 'ios-snow-outline',
    '621': 'ios-snow-outline',
    '622': 'ios-snow-outline',
    
    '701': 'ios-cloudy-outline',
    '711': 'ios-cloudy-outline',
    '721': 'ios-cloudy-outline',
    '731': 'ios-cloudy-outline',
    '741': 'ios-cloudy-outline',
    '751': 'ios-cloudy-outline',
    '761': 'ios-cloudy-outline',
    '762': 'ios-cloudy-outline',
    '771': 'ios-cloudy-outline',
    '781': 'ios-cloudy-outline',
    
    '800': 'ios-sunny-outline',

    '801': 'ios-partly-sunny-outline',
    '802': 'ios-cloudy-outline',
    '803': 'ios-cloudy-outline',
    '804': 'ios-cloudy-outline',
};

function getIconName(iconName) {
    var iconCodeParts = iconNameByOwmCode[iconName]
    if (!iconCodeParts)
        return 'ios-alert-outline';
    return iconCodeParts
}

