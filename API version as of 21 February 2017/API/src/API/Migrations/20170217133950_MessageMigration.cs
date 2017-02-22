using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Metadata;

namespace API.Migrations
{
    public partial class MessageMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Messages",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    ChatId = table.Column<int>(nullable: true),
                    IsRead = table.Column<bool>(nullable: false),
                    MessageContent = table.Column<string>(nullable: true),
                    ReplyMessage = table.Column<string>(nullable: true),
                    ReplyTime = table.Column<DateTime>(nullable: true),
                    SentTime = table.Column<DateTime>(nullable: true),
                    userIdFrom = table.Column<Guid>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Messages", x => x.Id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Messages");
        }
    }
}
