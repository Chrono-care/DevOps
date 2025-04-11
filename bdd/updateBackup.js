console.clear()
// LIBRARY DECLARATION
const fs = require("fs")


// CONSTANT DECLARATION
const BDD_FILE = "bdd/postgres.sql"
const COMMAND = `select setval('public.<sequence>', coalesce((select max(id)+1 from public.<table>),1),false);`
const BACKLINE = new RegExp("\r\n|\r|\n","g")
const SEQUENCE_REGEX = new RegExp("_id_seq")


const PAYLOAD = [
    "-- GENERATED WITH NODEJS SCRIPT",
]

// FUNCTION DECLARATION
async function generate_sequence_evaluation()
{
    try
    {
        const fileContent = fs.readFileSync(BDD_FILE)
        const SEQUENCES = fileContent.toString().split(BACKLINE).filter((line)=>{
            return line.includes("CREATE SEQUENCE")
        }).map((line)=>{
            return line.split(" ").pop().split(".").pop()
        })

        const TABLES_NAME = SEQUENCES.map((sequence)=>{
            return sequence.replace(SEQUENCE_REGEX,"")
        })

        SEQUENCES.forEach((sequence,index)=>{
            PAYLOAD.push(COMMAND.replace("<sequence>",sequence).replace("<table>",TABLES_NAME[index]))
        })
    }
    catch(err)
    {
        throw err
    }
}
// MAIN
async function main()
{
    await generate_sequence_evaluation()
    fs.appendFile(BDD_FILE,PAYLOAD.join("\r\n"),(err)=>{
        if(err) throw err;
        console.log("Database File updated successfully.")
    })
}

main()