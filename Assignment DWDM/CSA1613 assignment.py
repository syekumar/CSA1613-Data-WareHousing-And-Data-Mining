# ============================================================
# CSA1613 - DATA WAREHOUSING AND DATA MINING
# E-COMMERCE DATA WAREHOUSE AND CUSTOMER CHURN PREDICTION
#
# Complete Self-Contained Implementation
# Generates Dataset + ETL + Warehouse + OLAP + ML + Graphs
# ============================================================

import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.model_selection import train_test_split
from sklearn.model_selection import StratifiedKFold
from sklearn.model_selection import cross_val_score

from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline

from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC

from sklearn.metrics import (
    accuracy_score,
    precision_score,
    recall_score,
    f1_score,
    confusion_matrix,
    classification_report
)

# ============================================================
# SETTINGS
# ============================================================

np.random.seed(42)

BASE_DIR = "ecommerce_project"

DATA_DIR = os.path.join(
    BASE_DIR,
    "data"
)

GRAPH_DIR = os.path.join(
    BASE_DIR,
    "graphs"
)

RESULT_DIR = os.path.join(
    BASE_DIR,
    "results"
)

WAREHOUSE_DIR = os.path.join(
    BASE_DIR,
    "warehouse"
)

os.makedirs(DATA_DIR, exist_ok=True)
os.makedirs(GRAPH_DIR, exist_ok=True)
os.makedirs(RESULT_DIR, exist_ok=True)
os.makedirs(WAREHOUSE_DIR, exist_ok=True)

print("\n")
print("=" * 70)
print("CSA1613 - DATA WAREHOUSING AND DATA MINING")
print("E-COMMERCE DATA WAREHOUSE AND CUSTOMER CHURN PREDICTION")
print("=" * 70)


# ============================================================
# 1. GENERATE CUSTOMER DATA
# ============================================================

print("\n[1/15] Generating Customer Data...")

N_CUSTOMERS = 1000

customers = pd.DataFrame({
    "customer_id":
        [f"C{i:04d}" for i in range(1, N_CUSTOMERS + 1)],

    "age":
        np.random.randint(18, 65, N_CUSTOMERS),

    "gender":
        np.random.choice(
            ["Male", "Female"],
            N_CUSTOMERS
        ),

    "region":
        np.random.choice(
            [
                "North",
                "South",
                "East",
                "West"
            ],
            N_CUSTOMERS
        )
})

customers["age_group"] = pd.cut(
    customers["age"],
    bins=[0, 25, 35, 50, 100],
    labels=[
        "18-25",
        "26-35",
        "36-50",
        "51+"
    ]
)

customers.to_csv(
    os.path.join(
        DATA_DIR,
        "customers.csv"
    ),
    index=False
)


# ============================================================
# 2. GENERATE PRODUCT DATA
# ============================================================

print("[2/15] Generating Product Data...")

N_PRODUCTS = 100

products = pd.DataFrame({

    "product_id":
        [f"P{i:03d}" for i in range(1, N_PRODUCTS + 1)],

    "category":
        np.random.choice(
            [
                "Electronics",
                "Clothing",
                "Home",
                "Books",
                "Sports"
            ],
            N_PRODUCTS
        ),

    "price":
        np.round(
            np.random.uniform(
                200,
                50000,
                N_PRODUCTS
            ),
            2
        )
})

products.to_csv(
    os.path.join(
        DATA_DIR,
        "products.csv"
    ),
    index=False
)


# ============================================================
# 3. GENERATE ORDER DATA
# ============================================================

print("[3/15] Generating Order Data...")

N_ORDERS = 8000

customer_ids = np.random.choice(
    customers["customer_id"],
    N_ORDERS
)

product_ids = np.random.choice(
    products["product_id"],
    N_ORDERS
)

order_dates = pd.date_range(
    start="2024-01-01",
    end="2025-12-31",
    periods=N_ORDERS
)

orders = pd.DataFrame({

    "order_id":
        [f"O{i:05d}" for i in range(1, N_ORDERS + 1)],

    "customer_id":
        customer_ids,

    "product_id":
        product_ids,

    "order_date":
        order_dates,

    "quantity":
        np.random.randint(
            1,
            6,
            N_ORDERS
        ),

    "discount":
        np.round(
            np.random.uniform(
                0,
                30,
                N_ORDERS
            ),
            2
        )
})


orders = orders.merge(
    products[
        [
            "product_id",
            "price"
        ]
    ],
    on="product_id",
    how="left"
)

orders["sales_amount"] = np.round(
    orders["quantity"] *
    orders["price"] *
    (1 - orders["discount"] / 100),
    2
)

orders.drop(
    columns=["price"],
    inplace=True
)

orders.to_csv(
    os.path.join(
        DATA_DIR,
        "orders.csv"
    ),
    index=False
)


# ============================================================
# 4. PAYMENT DATA
# ============================================================

print("[4/15] Generating Payment Data...")

payments = pd.DataFrame({

    "payment_id":
        [f"PAY{i:05d}" for i in range(1, N_ORDERS + 1)],

    "order_id":
        orders["order_id"],

    "payment_method":
        np.random.choice(
            [
                "UPI",
                "Credit Card",
                "Debit Card",
                "Net Banking",
                "Cash on Delivery"
            ],
            N_ORDERS
        ),

    "payment_status":
        np.random.choice(
            [
                "Completed",
                "Completed",
                "Completed",
                "Failed"
            ],
            N_ORDERS,
            p=[
                0.85,
                0.05,
                0.07,
                0.03
            ]
        )
})

payments.to_csv(
    os.path.join(
        DATA_DIR,
        "payments.csv"
    ),
    index=False
)


# ============================================================
# 5. DELIVERY DATA
# ============================================================

print("[5/15] Generating Delivery Data...")

deliveries = pd.DataFrame({

    "delivery_id":
        [f"D{i:05d}" for i in range(1, N_ORDERS + 1)],

    "order_id":
        orders["order_id"],

    "delivery_days":
        np.random.randint(
            1,
            12,
            N_ORDERS
        ),

    "delivery_status":
        np.random.choice(
            [
                "Delivered",
                "Delivered",
                "Delivered",
                "Delayed"
            ],
            N_ORDERS
        )
})

deliveries.to_csv(
    os.path.join(
        DATA_DIR,
        "deliveries.csv"
    ),
    index=False
)


# ============================================================
# 6. WEBSITE INTERACTION DATA
# ============================================================

print("[6/15] Generating Website Interaction Data...")

interactions = pd.DataFrame({

    "interaction_id":
        [
            f"I{i:05d}"
            for i in range(
                1,
                6001
            )
        ],

    "customer_id":
        np.random.choice(
            customers["customer_id"],
            6000
        ),

    "session_duration":
        np.round(
            np.random.uniform(
                1,
                60,
                6000
            ),
            2
        ),

    "pages_viewed":
        np.random.randint(
            1,
            20,
            6000
        ),

    "cart_additions":
        np.random.randint(
            0,
            6,
            6000
        )
})

interactions.to_csv(
    os.path.join(
        DATA_DIR,
        "interactions.csv"
    ),
    index=False
)


print("\n✓ All datasets generated successfully.")


# ============================================================
# 7. DISPLAY DATASET INFORMATION
# ============================================================

print("\n")
print("=" * 70)
print("DATASET INFORMATION")
print("=" * 70)

print(
    "\nCustomers:",
    customers.shape
)

print(
    "Products:",
    products.shape
)

print(
    "Orders:",
    orders.shape
)

print(
    "Payments:",
    payments.shape
)

print(
    "Deliveries:",
    deliveries.shape
)

print(
    "Interactions:",
    interactions.shape
)


# ============================================================
# 8. ETL - DATA INTEGRATION
# ============================================================

print("\n[7/15] Performing ETL Integration...")

orders["order_date"] = pd.to_datetime(
    orders["order_date"]
)

orders["year"] = (
    orders["order_date"].dt.year
)

orders["month"] = (
    orders["order_date"].dt.month
)

orders["quarter"] = (
    orders["order_date"].dt.quarter
)

orders["date_key"] = (
    orders["order_date"]
    .dt.strftime("%Y%m%d")
    .astype(int)
)


data = orders.merge(
    customers,
    on="customer_id",
    how="left"
)

data = data.merge(
    products,
    on="product_id",
    how="left"
)

data = data.merge(
    payments,
    on="order_id",
    how="left"
)

data = data.merge(
    deliveries,
    on="order_id",
    how="left"
)


# ============================================================
# 9. DATA PREPROCESSING
# ============================================================

print("[8/15] Performing Data Preprocessing...")

print(
    "\nMissing values BEFORE cleaning:"
)

print(
    data.isnull().sum()
)


# Missing value handling

numeric_columns = data.select_dtypes(
    include=np.number
).columns

for column in numeric_columns:

    data[column] = data[column].fillna(
        data[column].median()
    )


categorical_columns = data.select_dtypes(
    exclude=np.number
).columns

for column in categorical_columns:

    data[column] = data[column].fillna(
        "Unknown"
    )


# Duplicate removal

before = len(data)

data.drop_duplicates(
    inplace=True
)

after = len(data)

print(
    f"\nDuplicates removed: {before - after}"
)


print(
    "\nMissing values AFTER cleaning:"
)

print(
    data.isnull().sum().sum()
)


data.to_csv(
    os.path.join(
        WAREHOUSE_DIR,
        "integrated_fact_data.csv"
    ),
    index=False
)


# ============================================================
# 10. CREATE DIMENSION TABLES
# ============================================================

print("\n[9/15] Creating Data Warehouse Tables...")


dim_customer = customers.copy()

dim_product = products.copy()

dim_date = orders[
    [
        "date_key",
        "order_date",
        "year",
        "quarter",
        "month"
    ]
].drop_duplicates()


dim_payment = payments[
    [
        "payment_id",
        "payment_method",
        "payment_status"
    ]
]


fact_sales = data[
    [
        "order_id",
        "customer_id",
        "product_id",
        "date_key",
        "payment_id",
        "quantity",
        "sales_amount",
        "discount"
    ]
]


dim_customer.to_csv(
    os.path.join(
        WAREHOUSE_DIR,
        "dim_customer.csv"
    ),
    index=False
)

dim_product.to_csv(
    os.path.join(
        WAREHOUSE_DIR,
        "dim_product.csv"
    ),
    index=False
)

dim_date.to_csv(
    os.path.join(
        WAREHOUSE_DIR,
        "dim_date.csv"
    ),
    index=False
)

dim_payment.to_csv(
    os.path.join(
        WAREHOUSE_DIR,
        "dim_payment.csv"
    ),
    index=False
)

fact_sales.to_csv(
    os.path.join(
        WAREHOUSE_DIR,
        "fact_sales.csv"
    ),
    index=False
)


# ============================================================
# 11. STAR SCHEMA DIAGRAM
# ============================================================

print("[10/15] Creating Star Schema Diagram...")


fig, ax = plt.subplots(
    figsize=(14, 9)
)

ax.axis("off")


ax.text(
    0.50,
    0.50,
    "FACT_SALES\n\n"
    "order_id\n"
    "customer_id\n"
    "product_id\n"
    "date_key\n"
    "payment_id\n"
    "quantity\n"
    "sales_amount\n"
    "discount",
    ha="center",
    va="center",
    fontsize=11,
    bbox=dict(
        boxstyle="round,pad=0.8"
    )
)


dimension_data = [

    (
        0.15,
        0.75,
        "DIM_CUSTOMER\n\n"
        "customer_id\n"
        "age\n"
        "gender\n"
        "region\n"
        "age_group"
    ),

    (
        0.85,
        0.75,
        "DIM_PRODUCT\n\n"
        "product_id\n"
        "category\n"
        "price"
    ),

    (
        0.15,
        0.20,
        "DIM_DATE\n\n"
        "date_key\n"
        "order_date\n"
        "year\n"
        "quarter\n"
        "month"
    ),

    (
        0.85,
        0.20,
        "DIM_PAYMENT\n\n"
        "payment_id\n"
        "payment_method\n"
        "payment_status"
    )
]


for x, y, text in dimension_data:

    ax.text(
        x,
        y,
        text,
        ha="center",
        va="center",
        fontsize=10,
        bbox=dict(
            boxstyle="round,pad=0.7"
        )
    )

    ax.annotate(
        "",
        xy=(0.50, 0.50),
        xytext=(x, y),
        arrowprops=dict(
            arrowstyle="->",
            linewidth=1.5
        )
    )


plt.title(
    "Star Schema - E-Commerce Data Warehouse",
    fontsize=18,
    fontweight="bold"
)

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "01_star_schema.png"
    ),
    dpi=300,
    bbox_inches="tight"
)

plt.close()


# ============================================================
# 12. ETL DIAGRAM
# ============================================================

print("Creating ETL Workflow Diagram...")


fig, ax = plt.subplots(
    figsize=(15, 6)
)

ax.axis("off")


steps = [
    "EXTRACT",
    "CLEAN",
    "TRANSFORM",
    "LOAD",
    "ANALYZE"
]


details = [
    "Customer\nOrders\nProducts",
    "Missing Values\nDuplicates\nOutliers",
    "Integration\nNormalization",
    "Fact +\nDimensions",
    "OLAP +\nClassification"
]


for i in range(5):

    x = 0.1 + i * 0.2

    ax.text(
        x,
        0.60,
        steps[i],
        ha="center",
        va="center",
        fontsize=13,
        fontweight="bold",
        bbox=dict(
            boxstyle="round,pad=0.6"
        )
    )

    ax.text(
        x,
        0.38,
        details[i],
        ha="center",
        va="center",
        fontsize=10
    )

    if i < 4:

        ax.annotate(
            "",
            xy=(x + 0.16, 0.60),
            xytext=(x + 0.08, 0.60),
            arrowprops=dict(
                arrowstyle="->",
                linewidth=2
            )
        )


plt.title(
    "ETL Pipeline",
    fontsize=18,
    fontweight="bold"
)

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "02_etl_pipeline.png"
    ),
    dpi=300,
    bbox_inches="tight"
)

plt.close()


# ============================================================
# 13. HIGH SELLING PRODUCTS
# ============================================================

print("Creating High-Selling Products Graph...")


top_products = data.groupby(
    "product_id"
)["sales_amount"].sum().sort_values(
    ascending=False
).head(10)


plt.figure(
    figsize=(10, 6)
)

top_products.sort_values().plot(
    kind="barh"
)

plt.title(
    "Top 10 High-Selling Products"
)

plt.xlabel(
    "Total Sales"
)

plt.ylabel(
    "Product ID"
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "03_high_selling_products.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 14. REGIONAL PERFORMANCE
# ============================================================

print("Creating Regional Performance Graph...")


regional_sales = data.groupby(
    "region"
)["sales_amount"].sum().sort_values(
    ascending=False
)


plt.figure(
    figsize=(9, 6)
)

regional_sales.plot(
    kind="bar"
)

plt.title(
    "Regional Sales Performance"
)

plt.xlabel(
    "Region"
)

plt.ylabel(
    "Total Sales"
)

plt.xticks(
    rotation=0
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "04_regional_performance.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 15. SEASONAL SALES
# ============================================================

print("Creating Seasonal Sales Graph...")


monthly_sales = data.groupby(
    "month"
)["sales_amount"].sum()


plt.figure(
    figsize=(10, 6)
)

plt.plot(
    monthly_sales.index,
    monthly_sales.values,
    marker="o"
)

plt.title(
    "Monthly Seasonal Sales Pattern"
)

plt.xlabel(
    "Month"
)

plt.ylabel(
    "Sales"

)

plt.xticks(
    range(1, 13)
)

plt.grid(
    alpha=0.3
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "05_seasonal_sales.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 16. CUSTOMER SEGMENTATION
# ============================================================

print("Creating Customer Segmentation...")


customer_summary = data.groupby(
    "customer_id"
).agg(

    total_spend=(
        "sales_amount",
        "sum"
    ),

    total_orders=(
        "order_id",
        "count"
    ),

    avg_order_value=(
        "sales_amount",
        "mean"
    )

).reset_index()


customer_summary[
    "segment"
] = pd.qcut(
    customer_summary["total_spend"],
    q=3,
    labels=[
        "Low Value",
        "Medium Value",
        "High Value"
    ]
)


segment_counts = customer_summary[
    "segment"
].value_counts()


plt.figure(
    figsize=(8, 7)
)

plt.pie(
    segment_counts.values,
    labels=segment_counts.index,
    autopct="%1.1f%%",
    startangle=90
)

plt.title(
    "Customer Segmentation"
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "06_customer_segmentation.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 17. OLAP PIVOT
# ============================================================

print("Creating OLAP Pivot Heatmap...")


pivot = pd.pivot_table(
    data,
    values="sales_amount",
    index="region",
    columns="category",
    aggfunc="sum",
    fill_value=0
)


print("\nOLAP PIVOT TABLE")
print("=" * 70)

print(
    pivot.round(2)
)


plt.figure(
    figsize=(10, 6)
)

sns.heatmap(
    pivot,
    annot=True,
    fmt=".0f"
)

plt.title(
    "OLAP Pivot - Regional Sales by Category"
)

plt.xlabel(
    "Product Category"
)

plt.ylabel(
    "Region"
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "07_olap_pivot.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 18. ROLL-UP
# ============================================================

print("\nOLAP ROLL-UP")


rollup = data.groupby(
    "region"
)["sales_amount"].sum().sort_values(
    ascending=False
)

print(
    rollup.round(2)
)


plt.figure(
    figsize=(9, 6)
)

rollup.plot(
    kind="bar"
)

plt.title(
    "OLAP Roll-Up - Sales by Region"
)

plt.xlabel(
    "Region"
)

plt.ylabel(
    "Total Sales"
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "08_olap_rollup.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 19. DRILL-DOWN
# ============================================================

print("\nOLAP DRILL-DOWN")


drilldown = data.groupby(
    [
        "year",
        "quarter",
        "month"
    ]
)["sales_amount"].sum().reset_index()


print(
    drilldown.head(20).round(2)
)


plt.figure(
    figsize=(12, 6)
)

plt.plot(
    range(len(drilldown)),
    drilldown["sales_amount"],
    marker="o"
)

plt.title(
    "OLAP Drill-Down - Year → Quarter → Month"
)

plt.xlabel(
    "Time Hierarchy"
)

plt.ylabel(
    "Sales"
)

plt.grid(
    alpha=0.3
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "09_olap_drilldown.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 20. CHURN DATASET
# ============================================================

print("\n[11/15] Preparing Customer Churn Dataset...")


customer_features = data.groupby(
    "customer_id"
).agg(

    total_orders=(
        "order_id",
        "count"
    ),

    total_spend=(
        "sales_amount",
        "sum"
    ),

    avg_order_value=(
        "sales_amount",
        "mean"
    ),

    avg_delivery_days=(
        "delivery_days",
        "mean"
    ),

    avg_discount=(
        "discount",
        "mean"
    ),

    last_purchase=(
        "order_date",
        "max"
    )

).reset_index()


interaction_features = interactions.groupby(
    "customer_id"
).agg(

    total_sessions=(
        "interaction_id",
        "count"
    ),

    avg_session_duration=(
        "session_duration",
        "mean"
    ),

    avg_pages_viewed=(
        "pages_viewed",
        "mean"
    ),

    total_cart_additions=(
        "cart_additions",
        "sum"
    )

).reset_index()


churn_data = customer_features.merge(
    interaction_features,
    on="customer_id",
    how="left"
)


churn_data = churn_data.fillna(0)


reference_date = pd.Timestamp(
    "2025-12-31"
)


churn_data["recency_days"] = (
    reference_date -
    pd.to_datetime(
        churn_data["last_purchase"]
    )
).dt.days


# Churn definition

churn_data["churn"] = (
    churn_data["recency_days"] > 180
).astype(int)


print(
    "\nChurn Distribution:"
)

print(
    churn_data["churn"].value_counts()
)


# ============================================================
# 21. CHURN DISTRIBUTION
# ============================================================

print("Creating Churn Distribution Graph...")


churn_counts = churn_data[
    "churn"
].value_counts()


plt.figure(
    figsize=(8, 6)
)

plt.bar(
    [
        "Not Churned",
        "Churned"
    ],
    [
        churn_counts.get(0, 0),
        churn_counts.get(1, 0)
    ]
)

plt.title(
    "Customer Churn Distribution"
)

plt.xlabel(
    "Customer Status"
)

plt.ylabel(
    "Number of Customers"
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "10_churn_distribution.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 22. MACHINE LEARNING
# ============================================================

print("\n[12/15] Training Classification Models...")


features = [
    "total_orders",
    "total_spend",
    "avg_order_value",
    "avg_delivery_days",
    "avg_discount",
    "total_sessions",
    "avg_session_duration",
    "avg_pages_viewed",
    "total_cart_additions",
    "recency_days"
]


X = churn_data[
    features
]

y = churn_data[
    "churn"
]


X_train, X_test, y_train, y_test = train_test_split(

    X,
    y,

    test_size=0.20,

    random_state=42,

    stratify=y
)


# ============================================================
# 23. DECISION TREE
# ============================================================

decision_tree = DecisionTreeClassifier(
    max_depth=5,
    random_state=42
)

decision_tree.fit(
    X_train,
    y_train
)

dt_pred = decision_tree.predict(
    X_test
)


# ============================================================
# 24. NAIVE BAYES
# ============================================================

naive_bayes = Pipeline([

    (
        "scaler",
        StandardScaler()
    ),

    (
        "model",
        GaussianNB()
    )
])


naive_bayes.fit(
    X_train,
    y_train
)

nb_pred = naive_bayes.predict(
    X_test
)


# ============================================================
# 25. SVM
# ============================================================

svm = Pipeline([

    (
        "scaler",
        StandardScaler()
    ),

    (
        "model",
        SVC(
            kernel="rbf",
            probability=True,
            random_state=42
        )
    )
])


svm.fit(
    X_train,
    y_train
)

svm_pred = svm.predict(
    X_test
)


# ============================================================
# 26. MODEL EVALUATION
# ============================================================

def evaluate_model(
    name,
    predictions
):

    return {

        "Model":
            name,

        "Accuracy":
            accuracy_score(
                y_test,
                predictions
            ) * 100,

        "Precision":
            precision_score(
                y_test,
                predictions,
                zero_division=0
            ) * 100,

        "Recall":
            recall_score(
                y_test,
                predictions,
                zero_division=0
            ) * 100,

        "F1 Score":
            f1_score(
                y_test,
                predictions,
                zero_division=0
            ) * 100
    }


results = pd.DataFrame([

    evaluate_model(
        "Decision Tree",
        dt_pred
    ),

    evaluate_model(
        "Naive Bayes",
        nb_pred
    ),

    evaluate_model(
        "SVM",
        svm_pred
    )

])


print("\n")
print("=" * 70)
print("CLASSIFICATION MODEL RESULTS")
print("=" * 70)

print(
    results.round(2).to_string(
        index=False
    )
)


results.to_csv(
    os.path.join(
        RESULT_DIR,
        "model_results.csv"
    ),
    index=False
)


# ============================================================
# 27. MODEL COMPARISON GRAPH
# ============================================================

print("\n[13/15] Creating Model Comparison Graph...")


model_plot = results.set_index(
    "Model"
)


model_plot[
    [
        "Accuracy",
        "Precision",
        "Recall",
        "F1 Score"
    ]
].plot(
    kind="bar",
    figsize=(11, 6)
)


plt.title(
    "Decision Tree vs Naive Bayes vs SVM"
)

plt.xlabel(
    "Classification Model"
)

plt.ylabel(
    "Performance (%)"
)

plt.ylim(
    0,
    100
)

plt.xticks(
    rotation=0
)

plt.legend(
    title="Metrics"
)

plt.grid(
    axis="y",
    alpha=0.3
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "11_model_comparison.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 28. CONFUSION MATRICES
# ============================================================

print("Creating Confusion Matrices...")


prediction_dict = {

    "Decision Tree":
        dt_pred,

    "Naive Bayes":
        nb_pred,

    "SVM":
        svm_pred
}


for name, prediction in prediction_dict.items():

    cm = confusion_matrix(
        y_test,
        prediction
    )


    plt.figure(
        figsize=(7, 6)
    )


    sns.heatmap(
        cm,
        annot=True,
        fmt="d",
        xticklabels=[
            "Not Churn",
            "Churn"
        ],
        yticklabels=[
            "Not Churn",
            "Churn"
        ]
    )


    plt.title(
        f"{name} - Confusion Matrix"
    )

    plt.xlabel(
        "Predicted"
    )

    plt.ylabel(
        "Actual"
    )

    plt.tight_layout()


    filename = (
        name.lower()
        .replace(
            " ",
            "_"
        )
        + "_confusion_matrix.png"
    )


    plt.savefig(
        os.path.join(
            GRAPH_DIR,
            filename
        ),
        dpi=300
    )

    plt.close()


# ============================================================
# 29. CROSS VALIDATION
# ============================================================

print("\n[14/15] Performing 5-Fold Cross Validation...")


cv = StratifiedKFold(
    n_splits=5,
    shuffle=True,
    random_state=42
)


models = {

    "Decision Tree":
        decision_tree,

    "Naive Bayes":
        naive_bayes,

    "SVM":
        svm
}


cv_results = {}


for name, model in models.items():

    scores = cross_val_score(

        model,

        X,

        y,

        cv=cv,

        scoring="f1"

    )

    cv_results[name] = (
        scores * 100
    )


    print(
        f"{name}:",
        np.round(
            scores * 100,
            2
        )
    )


plt.figure(
    figsize=(10, 6)
)


for name, scores in cv_results.items():

    plt.plot(

        range(1, 6),

        scores,

        marker="o",

        label=name

    )


plt.title(
    "5-Fold Cross-Validation F1 Score"
)

plt.xlabel(
    "Fold"
)

plt.ylabel(
    "F1 Score (%)"
)

plt.xticks(
    range(1, 6)
)

plt.legend()

plt.grid(
    alpha=0.3
)

plt.tight_layout()


plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "15_cross_validation.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 30. CHURN RISK
# ============================================================

print("\n[15/15] Creating Churn Risk Analysis...")


best_model_name = results.loc[
    results["F1 Score"].idxmax(),
    "Model"
]


if best_model_name == "Decision Tree":

    best_model = decision_tree

elif best_model_name == "Naive Bayes":

    best_model = naive_bayes

else:

    best_model = svm


probability = best_model.predict_proba(
    X
)[:, 1]


churn_data[
    "churn_probability"
] = probability * 100


churn_data[
    "risk_level"
] = pd.cut(

    churn_data[
        "churn_probability"
    ],

    bins=[
        -1,
        30,
        60,
        100
    ],

    labels=[
        "Low Risk",
        "Medium Risk",
        "High Risk"
    ]
)


risk_counts = churn_data[
    "risk_level"
].value_counts()


print(
    "\nChurn Risk Distribution:"
)

print(
    risk_counts
)


plt.figure(
    figsize=(8, 6)
)


risk_counts.plot(
    kind="bar"
)


plt.title(
    "Customer Churn Risk Levels"
)

plt.xlabel(
    "Risk Level"
)

plt.ylabel(
    "Number of Customers"
)

plt.xticks(
    rotation=0
)

plt.tight_layout()


plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "16_churn_risk.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 31. SPENDING VS CHURN
# ============================================================

plt.figure(
    figsize=(9, 6)
)


sns.boxplot(
    data=churn_data,
    x="churn",
    y="total_spend"
)


plt.title(
    "Customer Spending vs Churn"
)

plt.xlabel(
    "Churn (0 = No, 1 = Yes)"
)

plt.ylabel(
    "Total Spending"
)

plt.tight_layout()


plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "17_spending_vs_churn.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 32. RECENCY VS CHURN
# ============================================================

plt.figure(
    figsize=(9, 6)
)


sns.boxplot(
    data=churn_data,
    x="churn",
    y="recency_days"
)


plt.title(
    "Purchase Recency vs Churn"
)

plt.xlabel(
    "Churn (0 = No, 1 = Yes)"
)

plt.ylabel(
    "Days Since Last Purchase"
)

plt.tight_layout()


plt.savefig(
    os.path.join(
        GRAPH_DIR,
        "18_recency_vs_churn.png"
    ),
    dpi=300
)

plt.close()


# ============================================================
# 33. SAVE CHURN DATA
# ============================================================

churn_data.to_csv(
    os.path.join(
        RESULT_DIR,
        "customer_churn_analysis.csv"
    ),
    index=False
)


# ============================================================
# 34. FINAL REPORT
# ============================================================

print("\n")
print("=" * 70)
print("FINAL ANALYSIS")
print("=" * 70)


print(
    "\nTotal Customers:",
    len(customers)
)

print(
    "Total Products:",
    len(products)
)

print(
    "Total Orders:",
    len(orders)
)

print(
    "Total Sales: ₹",
    round(
        data["sales_amount"].sum(),
        2
    )
)

print(
    "Churned Customers:",
    churn_data["churn"].sum()
)

print(
    "Non-Churned Customers:",
    (churn_data["churn"] == 0).sum()
)


print(
    "\nBest Classification Model:"
)

print(
    best_model_name
)


best_score = results.loc[
    results["F1 Score"].idxmax(),
    "F1 Score"
]


print(
    "Best F1 Score:",
    round(
        best_score,
        2
    ),
    "%"
)


print("\n")
print("=" * 70)
print("FILES GENERATED")
print("=" * 70)


print(
    "\nData:"
)

print(
    "  ecommerce_project/data/"
)


print(
    "\nData Warehouse:"
)

print(
    "  ecommerce_project/warehouse/"
)


print(
    "\nResults:"
)

print(
    "  ecommerce_project/results/"
)


print(
    "\nGraphs:"
)

print(
    "  ecommerce_project/graphs/"
)


print("\n")
print("=" * 70)
print("IMPLEMENTATION COMPLETED SUCCESSFULLY")
print("=" * 70)
