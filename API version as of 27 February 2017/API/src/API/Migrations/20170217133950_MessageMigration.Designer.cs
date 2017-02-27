using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using API.Models;

namespace API.Migrations
{
    [DbContext(typeof(ServiceContext))]
    [Migration("20170217133950_MessageMigration")]
    partial class MessageMigration
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
            modelBuilder
                .HasAnnotation("ProductVersion", "1.0.0-rtm-21431")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("API.Models.Message", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int?>("ChatId");

                    b.Property<bool>("IsRead");

                    b.Property<string>("MessageContent");

                    b.Property<string>("ReplyMessage");

                    b.Property<DateTime?>("ReplyTime");

                    b.Property<DateTime?>("SentTime");

                    b.Property<Guid>("userIdFrom");

                    b.HasKey("Id");

                    b.ToTable("Messages");
                });
        }
    }
}
