-- CreateTable
CREATE TABLE "User" (
    "u_id" TEXT NOT NULL,
    "u_gmail" TEXT NOT NULL,
    "u_username" TEXT NOT NULL,
    "u_password" TEXT NOT NULL,
    "u_role" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("u_id")
);

-- CreateTable
CREATE TABLE "Expense" (
    "e_id" TEXT NOT NULL,
    "e_date" TIMESTAMP(3) NOT NULL,
    "e_des" TEXT NOT NULL,
    "e_price" DOUBLE PRECISION NOT NULL,
    "userId" TEXT NOT NULL,
    "cid" TEXT NOT NULL,
    CONSTRAINT "Expense_pkey" PRIMARY KEY ("e_id")
);

-- CreateTable
CREATE TABLE "Category" (
    "c_id" TEXT NOT NULL,
    "c_title" TEXT NOT NULL,
    "c_color" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("c_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_u_gmail_key" ON "User"("u_gmail");

-- AddForeignKey
ALTER TABLE "Expense" ADD CONSTRAINT "Expense_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("u_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Expense" ADD CONSTRAINT "Expense_cid_fkey" FOREIGN KEY ("cid") REFERENCES "Category"("c_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("u_id") ON DELETE RESTRICT ON UPDATE CASCADE;
