<head>
    <title>Israel Product Checker</title>
    <!-- Include Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Center everything */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f2f2f2;
        }

        .container {
            text-align: center;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }

        h2 {
            font-size: 24px;
            color: #333;
        }

        p {
            font-size: 18px;
            color: #666;
        }

        .product-input {
            font-size: 18px;
            padding: 10px;
            width: 80%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .check-button {
            font-size: 18px;
            padding: 10px 20px;
            cursor: pointer;
            display: block;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            transition: background-color 0.2s;
            margin: 10px auto; /* Center the button horizontally */
        }

        .check-button:hover {
            background-color: #0056b3;
        }

        .result {
            font-size: 18px;
            margin-top: 10px;
            display: none;
            color: #333;
        }

        .icon {
            font-size: 24px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Israel Product Checker</h2>
        <p>Enter the name of a product to check its association with Israel:</p>
        <input type="text" id="productInput" class="product-input" placeholder="Product Name">
        <button id="checkButton" class="check-button">Check Product</button>
        <div id="result" class="result"></div>
    </div>

    <script>
        const productInput = document.getElementById('productInput');
        const checkButton = document.getElementById('checkButton');
        const result = document.getElementById('result');

        // List of products associated with or supported by Israel
        const israelProducts = [
            "Aramis", "CocaCola", "HP", "Intel", "Signal", "Facebook", "Instagram",
            "WhatsApp", "Clinique", "Prescriptives", "Origins Natural Resources",
            "MAC cosmetics", "La Mer", "Bobby brown Essentials", "Tommy Hilfiger Toiletries",
            "Jane", "Donna Karan Cosmetics", "Aveda", "Stila Cosmetics", "Jo Malone",
            "Bumble and Bumble", "Kate Spade", "AirBnb", "UpWork", "Fiverr", "Hp",
            "Puma", "Oracle", "Siemens", "Starbucks", "Johnson and Johnson", "Nestle",
            "Motorola", "McDonald’s", "L’Oréal", "Coca cola", "Nokia", "Revlon", "Victoria’s secret",
            "Walmart", "Wix", "Sprite", "Kitkat", "Nido", "Walls", "Nescafe", "Lifebuoy", "Nesquik",
            "Burger King", "Hardees", "Subway", "Mars", "PepsiCo", "Cadbury", "Twix", "Lays",
            "Tang", "Lipton", "Pringles", "Pampers", "Lego", "Nike", "Ford", "Bounty", "Tide",
            "Snickers", "Dove", "Ariel", "Vim", "Toblerone", "Gillette", "Energizer", "Milo",
            "Maggie", "Baskin robin", "CNN", "National Geographic", "Caltex", "Fanta", "IBM", "Starbucks",
            "Burger King", "McDonald's", "Dominos", "Pizza Hut", "KFC", "Dunkin donuts", "Papa Johns",
            "Coca cola", "Smartwater", "Dogadan", "Innocent", "Fresca", "Fanta", "Dasani", "Sprite",
            "Coke", "Powerade", "Costa coffee", "Schweppes", "Danon", "Evlan", "Alpro", "Volvic", "Actimel",
            "Activia", "Nestle", "Purelife", "Quality street", "Smarties", "Cheerios", "Milo", "Nesquick",
            "Nescafe", "Aero", "Haagen-Dazs", "Original Shredded wheat", "Vittel", "Lion", "Milky bar", "Kitkat",
            "Movenpick", "Maggie", "Nature's bounty", "S.Pellegrino", "Buxton", "Carnation", "Cerelac",
            "Coffee mate", "Felix", "Gerben", "Strauss group", "Sabra", "Culligan water", "Activia", "Actimel",
            "Cheetos", "Doritos", "Carmel Agrexco", "Jaffa", "Mehadrin", "HP", "Motorola", "Intel", "IBM",
            "AOL", "Siemens", "Sodastream", "Disney", "Axa", "Citi Bank", "HSBC", "Hyundai", "Chevron",
            "Rolls Royce", "JCB", "Kimberly - Clark", "Andrex", "Drynites", "Huggies", "Huggies-little swimmers",
            "Pull ups", "Kleenex", "Depend", "Kotex", "Estee Lauder", "Becca", "Mac", "Jo Malone", "Dr Jart+",
            "Bobbi brown", "Two faced", "Smashbox", "Tom Ford", "Clinique", "La Mer", "The Ordinary", "Origins",
            "Aveda", "Ahava", "Moroccan oil", "Revlon", "CND", "Christina Aguilera", "Britney spears fragrances",
            "Mitchum", "Almay", "Elizabeth Arden", "Juicy Couture", "American crew", "P&G", "Daz", "Clearblue",
            "Febreze", "Lenor", "Vicks", "Gillette", "Always", "Flash", "Pampers", "Oral B", "Olay", "Ariel",
            "Braun", "Bold 2 in 1", "Seven seas", "Fixodent", "Fairy", "Herbal essence", "Head and shoulders",
            "Aussie", "Tampax", "Pantene", "Johnson & Johnson", "Clean & clear", "Neutrogena", "Sudafed",
            "Imodium", "Benadryl", "Ogx", "Band Aid", "Listerine", "Nicorette", "Rogaine", "Aveeno", "Mayi moisture hair care",
            "Lubriderm", "L'Oreal Professional", "Victor rolf", "Urban decay", "Ralph Lauren", "Biotherm", "Valentino",
            "Mugler", "Yue sai", "Yves Saint Laurent", "Cacharel", "Maison Margiela", "Diesel", "Takami", "Aesop",
            "Giorgio Armani", "Essie", "SkinCeuticals", "Matrix", "Kiehls", "Prada", "Dark and lovely", "Stylenanda",
            "Lancome", "Carita Paris", "Niely Cosmeticos", "Mixa", "NYX", "Maybelline", "Skin better science", "Garnier",
            "Kerastase", "Redken", "Pureology", "La Roche-Posay", "Vichy", "CeraVe", "PUMA", "Victoria's Secret", "Chanel",
            "Zara", "M&S", "American Eagle", "Kylie Cosmetics", "River Island"
        ];

        productInput.addEventListener('input', () => {
            if (productInput.value.trim() === '') {
                checkButton.style.display = 'none';
            } else {
                checkButton.style.display = 'block';
            }
        });

        checkButton.addEventListener('click', () => {
            const productName = productInput.value.trim().toLowerCase(); // Convert input to lowercase
            const israelProduct = israelProducts.some(product => productName.includes(product.toLowerCase()));

            result.innerHTML = israelProduct
                ? `<i class="icon fas fa-times-circle" style="color: red"></i>${productInput.value} is associated with or supported by Israel.`
                : `<i class="icon fas fa-check-circle" style="color: green"></i>${productInput.value} is safe to go with.`;

            result.style.display = 'block';
        });
    </script>
</body>
